//
//  BradleApp.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

@main
struct BradleApp: App {
    @StateObject var gameRunner = GameRunner()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch gameRunner.location {
                case .start:
                    StartView()
                        .transition(.opacity)
                case .game:
                    GameView()
                        .transition(.opacity)
                }
            }
            // Handles transition from StartView to GameView
            .animation(.easeInOut, value: gameRunner.location)
            .fullScreenCover(isPresented: $gameRunner.showFullScreenCover) {
                if gameRunner.fullScreenCover == .victory {
                    gameRunner.hideKeyboard = true
                }
            } content: {
                gameRunner.fullScreenCover.screen
            }
            .sheet(isPresented: $gameRunner.showSheet) {
                gameRunner.sheet.screen
                    .presentationCornerRadius(12)
            }
        }
        .environmentObject(gameRunner)
    }
}

