//
//  BradleApp.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI
import SwiftData

@main
struct BradleApp: App {
    @State var gameRunner = GameRunner()
    @State var colorManager = ColorManager()
    let container = try! ModelContainer(for: BradleAccount.self)
    
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
            .onAppear {
                gameRunner.loadAccount(from: container.mainContext)
            }
            
            // Handles transition from StartView to GameView
            .animation(.easeInOut, value: gameRunner.location)
            .fullScreenCover(item: $gameRunner.fullScreenCover) {
                
                // TODO: What case is this for?
                if gameRunner.fullScreenCover == .gameOver {
                    gameRunner.hideKeyboard = true
                }
            } content: { cover in
                cover.screen
            }
            .sheet(item: $gameRunner.sheet) { sheet in
                sheet.screen
                    .presentationCornerRadius(12)
            }
        }
        .modelContainer(container)
        .environment(gameRunner)
        .environment(colorManager)
    }
}

