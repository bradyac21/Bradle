//
//  SettingsSheet.swift
//  Bradle
//
//  Created by Brady Carden on 2/12/26.
//

import SwiftUI

struct SettingsSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("hardMode") var hardMode: Bool = false
//    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
//    @AppStorage("highContrastMode") var highContrastMode: Bool = false
    @AppStorage("softwareKeyboardOnly") var softwareKeyboardOnly: Bool = false
    
    @Environment(ColorManager.self) var colorManager: ColorManager
    
    var body: some View {
        @Bindable var colorManager = colorManager
        ZStack {
            
            // Background color
            colorManager.gameBackground.ignoresSafeArea()
            
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                        })
                        .buttonStyle(.plain)
                    }
                    Text("SETTINGS")
                        .font(.custom(FontNames.bold, size: 20))
                }
                .padding(.vertical)
                .padding(.horizontal, 25)
                
                Spacer()
                
                VStack {
                    ToggleRow(
                        title: "Hard Mode",
                        description: "Any revealed hints must be used in subsequent guesses",
                        numLines: 2,
                        value: $hardMode
                    )
                    
                    ToggleRow(
                        title: "Dark Theme",
                        numLines: 0,
                        value: $colorManager.darkModeEnabled
                    )
                    
                    ToggleRow(
                        title: "High Contrast Mode",
                        description: "Contrast and colorblindness improvements",
                        value: $colorManager.highContrastEnabled
                    )
                    
                    ToggleRow(
                        title: "Onscreen Keyboard Input Only",
                        description: "Ignore key input except from the onscreen keyboard. Most helpful for users using speech recognizer or other assistive devices.",
                        numLines: 3,
                        value: $softwareKeyboardOnly
                    )
                }
                .padding(.horizontal, 12.5)

                Spacer()
            }
            .foregroundStyle(colorManager.textColor)
        }
    }
}

#Preview {
    VStack {
        EmptyView()
    }
    .sheet(isPresented: .constant(true)) {
        SettingsSheet()
            .presentationDetents([.medium])
            .environment(ColorManager())
    }
}

struct ToggleRow: View {
    var title: String
    var description: String? = nil
    var numLines: Int = 1
    @Binding var value: Bool

    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text(title)
                        .font(.custom(FontNames.medium, size: 20))
                    
                    if let description = description {
                        Text(description)
                            .font(.custom(FontNames.medium, size: 14))
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .containerRelativeFrame(.horizontal) { length, _ in
                    length * 0.7
                }
                Toggle(isOn: $value) {
                }
                .tint(colorManager.submittedStatusColors[safeKey: .correct])
            }
            Divider()
                .background(BradleColors.darkModeNotIncluded)
        }
        .containerRelativeFrame(.vertical) { height, _ in
            height * (0.125 + (CGFloat(numLines) * 0.05))
        }
    }
}
