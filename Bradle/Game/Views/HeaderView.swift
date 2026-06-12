//
//  HeaderView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct HeaderView: View {
    
    @Environment(ColorManager.self) var colorManager
    
    public var body: some View {
        ZStack {
            Text("BRADLE")
                .font(.custom(FontNames.bold, size: 17.5))
            
            HStack {
                Button("How to Play", systemImage: "questionmark.circle") {
                    AppState.shared.sheet = .howToPlay
                }
                
                #if DEBUG
                Button("Debug Options", systemImage: "info.circle"){
                    AppState.shared.fullScreenCover = .testing
                }
                .labelStyle(.iconOnly)
                .padding(.leading, 10)
                #endif
                    
                Spacer()
                
                Button("Badges", systemImage: "trophy") {
                    AppState.shared.sheet = .badges
                }
                .padding(.trailing, 10)
                
                Button("Settings", systemImage: "gearshape.fill") {
                    AppState.shared.sheet = .settings
                }

            }
        }
        
        .labelStyle(.iconOnly)
        .font(.system(size: 20))
        .foregroundStyle(colorManager.primary)
    }
}

#Preview {
    HeaderView()
        .background(BradleColors.darkModeBackground)
        .environment(ColorManager())
}
