//
//  AppLocation.swift
//  Bradle
//
//  Created by Brady Carden on 2/10/26.
//

import SwiftUI

enum AppLocation {
    case start
    case game
}

enum FullScreenCover: Identifiable, Equatable {
    case results(GameOverCase)
    
    #if DEBUG
    case testing
    #endif
    
    var id: Int {
        switch self {
        case .results(_): 0
            #if DEBUG
        case .testing: 1
            #endif
        }
    }
    
    @ViewBuilder
    var screen: some View {
        switch self {
        case .results(let gameOverCase):
            ResultsView(gameOverCase: gameOverCase)
            
        #if DEBUG
        case .testing:
            DevelopingView()
        #endif
        }
    }
}

enum BradleSheet: Identifiable, Equatable {
    case login(UseCase)
    case howToPlay
    case settings
    case badges
    
    var id: Int {
        switch self {
        case .login(_):
            return 0
        case .howToPlay:
            return 1
        case .settings:
            return 2
        case .badges:
            return 3
        }
    }
    
    @ViewBuilder
    var screen: some View {
        switch self {
        case .login(let useCase):
            LoginSheet(useCase: useCase)
        case .howToPlay:
            HowToPlaySheet()
                .presentationDetents([.large])
        case .settings:
            SettingsSheet()
                .presentationDetents([.fraction(AccountStore.isLoggedIn ? 0.45 : 0.4)])
        case .badges:
            BadgesSheet()
        }
    }
}
