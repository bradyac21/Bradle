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
    @Bindable var appState = AppState.shared
    let container = try! ModelContainer(for: BradleAccount.self)
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch appState.location {
                case .start:
                    StartView()
                        .transition(.opacity)
                case .game:
                    GameView()
                        .transition(.opacity)
                }
            }
            .onAppear {
                AccountStore.shared.loadAccount(from: container.mainContext)
            }
            
            // Handles transition from StartView to GameView
            .animation(.easeInOut, value: appState.location)
            .fullScreenCover(item: $appState.fullScreenCover) { cover in
                cover.screen
            }
            .sheet(item: $appState.sheet) { sheet in
                sheet.screen
                    .presentationCornerRadius(12)
            }
        }
        .modelContainer(container)
        .environment(gameRunner)
        .environment(colorManager)
    }
}

