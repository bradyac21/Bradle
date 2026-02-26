//
//  GameView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameRunner: GameRunner
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HeaderView()
                .containerRelativeFrame([.horizontal, .vertical]) { size, axis in
                    size * (axis == .horizontal ? 0.95 : 0.075)
                }
            
            Divider()
            Spacer()
            Text(gameRunner.alertMessage)
                .foregroundStyle(.white)
            Spacer()
            
            AttemptsView()
                .containerRelativeFrame([.horizontal, .vertical]) { size, axis in
                    size * (axis == .horizontal ? 0.75 : 0.5)
                }
            
            
            Spacer()
            
            if !gameRunner.hideKeyboard {
                KeyboardView()
                    .containerRelativeFrame(.vertical) { height, _ in
                        height * 0.25
                    }
            } else {
                PostgameButtons()
                    .containerRelativeFrame(.vertical) { height, _ in
                        height * 0.25
                    }
            }
        }
        .background(darkModeEnabled ? BradleColors.dark : BradleColors.lightModeBackground)
        .environmentObject(gameRunner)
    }
}

#Preview {
    GameView()
        .environmentObject(GameRunner())
}
