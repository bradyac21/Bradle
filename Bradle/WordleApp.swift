//
//  BradleApp.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

@main
struct BradleApp: App {
    @StateObject var bradleViewModel = BradleViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch bradleViewModel.location {
                case .start:
                    StartView()
                        .transition(.opacity)
                case .game:
                    GameView()
                        .transition(.opacity)
                }
            }
            // Handles transition from StartView to GameView
            .animation(.easeInOut, value: bradleViewModel.location)
            .fullScreenCover(isPresented: $bradleViewModel.showFullScreenCover) {
                if bradleViewModel.fullScreenCover == .victory {
                    bradleViewModel.hideKeyboard = true
                }
            } content: {
                bradleViewModel.fullScreenCover.screen
            }
            .sheet(isPresented: $bradleViewModel.showSheet) {
                bradleViewModel.sheet.screen
                    .presentationCornerRadius(12)
            }
        }
        .environmentObject(bradleViewModel)
    }
}

