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
    
    @Environment(ColorManager.self) var colorManager: ColorManager
    @EnvironmentObject var gameRunner: GameRunner
    
    var body: some View {
        @Bindable var colorManager = colorManager
        ZStack {
            
            // Background color
            colorManager.gameBackground.ignoresSafeArea()
            
            VStack {
                
                // MARK: Settings Sheet Header
                
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
                
                // MARK: Toggleable Settings
                
                // Hard Mode
                Toggle(isOn: Binding(
                    get: { hardMode },
                    set: { newValue in
                        if gameRunner.submittedAttempts.isEmpty || hardMode {
                            hardMode = newValue
                        } else {
                            gameRunner.showAlert(withMessage: .cannotEnableHardMode, duration: 1_500_000_000)
                        }
                    }
                )) {
                    Text(Strings.settingsHardModeTitle)
                        .font(.custom(FontNames.medium, size: 20))
                    Text(Strings.settingsHardModeBody)
                        .font(.custom(FontNames.medium, size: 14))
                }
                .opacity(gameRunner.submittedAttempts.isEmpty || hardMode ? 1.0 : 0.4)
                .padding(.vertical, 10)
                Divider()
                    .background(BradleColors.darkModeNotIncluded)
                
                // Dark Mode
                Toggle(isOn: $colorManager.darkModeEnabled) {
                    Text(Strings.settingsDarkModeTitle)
                        .font(.custom(FontNames.medium, size: 20))
                }
                .padding(.vertical, 10)
                Divider()
                    .background(BradleColors.darkModeNotIncluded)
                
                // High Contrast Mode
                Toggle(isOn: $colorManager.highContrastEnabled) {
                    Text(Strings.settingsHighContrastTitle)
                        .font(.custom(FontNames.medium, size: 20))
                    Text(Strings.settingsHighContrastBody)
                        .font(.custom(FontNames.medium, size: 14))
                }
                .padding(.vertical, 10)
                Divider()
                    .background(BradleColors.darkModeNotIncluded)
                
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 25)
            .foregroundStyle(colorManager.primary)
        }
    }
}

#Preview {
    VStack {
        EmptyView()
    }
    .sheet(isPresented: .constant(true)) {
        SettingsSheet()
            .presentationDetents([.fraction(0.4)])
            .environment(ColorManager())
    }
}
