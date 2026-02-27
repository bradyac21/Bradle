//
//  KeyView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct KeyView: View {
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    var key: KeyboardButton
    @State var color: Color = .clear
    @State var status: Status = .action
    
    @EnvironmentObject var gameRunner: GameRunner
    
    public var body: some View {
        Button {
            gameRunner.handlePress(from: key)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(darkModeEnabled ? status.darkModeColor : status.lightModeColor)
                
                key.icon
                    .foregroundStyle(darkModeEnabled ? .white : .black)
                    .animation(.easeIn, value: key)
            }
        }
        .onAppear {
            color = darkModeEnabled ? BradleColors.darkModeKeyboardFrameColor : BradleColors.lightModeKeyboardFrameColor
        }
        .buttonStyle(.plain)
        .onChange(of: gameRunner.keyboardManager.getButtonColor(for: key)) { _, newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.color = newValue
            }
        }
    }
}

#Preview {
    KeyView(key: KeyboardButton.A)
       .environmentObject(GameRunner())
}
