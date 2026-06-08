//
//  GameView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct GameView: View {
    @Environment(GameRunner.self) var gameRunner
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        ZStack {
            colorManager.defaultBackground.ignoresSafeArea()
                #if DEBUG
                .simultaneousGesture(
                    TapGesture(count: 3)
                        .onEnded {
                            AppState.shared.fullScreenCover = .testing
                        }
                )
                #endif
            VStack(alignment: .center, spacing: 0) {
                HeaderView()
                    .containerRelativeFrame([.horizontal, .vertical]) { size, axis in
                        size * (axis == .horizontal ? 0.95 : 0.075)
                    }
                
                Divider()
                
                Spacer()
                
                AttemptsView()
                    .containerRelativeFrame([.horizontal, .vertical]) { size, axis in
                        size * (axis == .horizontal ? 0.85 : 0.5)
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
            
            if let alertMessage = gameRunner.alertMessage {
                Text(alertMessage.string)
                    .font(.custom(FontNames.bold, size: 15))
                    .foregroundStyle(colorManager.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(colorManager.primary)
                    }
                    .padding(.bottom, 590)
                    .transition(.asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(1)
            }
        }
        .task {
            gameRunner.getTargetWord()
        }
        .background(colorManager.gameBackground)
    }
}

#Preview {
    GameView()
        .environment(GameRunner())
        .environment(ColorManager())
}
