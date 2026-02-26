//
//  KeyView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct KeyView: View {
    var key: KeyboardButton
    @State var color: Color = Color(UIColor.lightGray)
    
    @EnvironmentObject var gameRunner: GameRunner
    
    public var body: some View {
        Button {
            gameRunner.handlePress(from: key)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(color)
                
                key.icon
                    .foregroundStyle(.white)
                    .animation(.easeIn, value: key)
            }
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
