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

enum FullScreenCover {
    case victory
    case results
    case empty
    
    #if DEBUG
    case testing
    #endif
    
    var screen: some View {
        switch self {
        case .victory:
            AnyView(VictoryScreen())
        case .results:
            AnyView(ResultsView())
        case .empty:
            AnyView(EmptyView())
        #if DEBUG
        case .testing:
            AnyView(DevelopingView())
        #endif
        }
    }
}

enum BradleSheet {
    case login
    case empty
    case howToPlay
    case settings
    
    var screen: some View {
        switch self {
        case .login:
            AnyView(LogInSheet())
        case .empty:
            AnyView(EmptyView())
        case .howToPlay:
            AnyView(HowToPlaySheet()
                .presentationDetents([.large])
            )
        case .settings:
            AnyView(
                SettingsSheet()
                    .presentationDetents([.medium])
            )
        }
    }
}
