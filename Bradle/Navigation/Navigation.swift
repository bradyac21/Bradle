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
    case gameOver
    case results(BradleAccount)
    
    #if DEBUG
    case testing
    #endif
    
    var id: Int {
        switch self {
        case .gameOver: 0
        case .results(_): 1
            #if DEBUG
        case .testing: 2
            #endif
        }
    }
    
    @ViewBuilder
    var screen: some View {
        switch self {
        case .gameOver:
            GameOverView(gameOverCase: .victory)
        case .results(let account):
            ResultsView(account: account)
            
        #if DEBUG
        case .testing:
            DevelopingView()
        #endif
        }
    }
}

enum BradleSheet: Int, Identifiable {
    case login
    case howToPlay
    case settings
    
    var id: Int { self.rawValue }
    
    @ViewBuilder
    var screen: some View {
        switch self {
        case .login:
            LoginSheet()
        case .howToPlay:
            HowToPlaySheet()
                .presentationDetents([.large])
        case .settings:
            SettingsSheet()
                .presentationDetents([.fraction(0.4)])
        }
    }
}
