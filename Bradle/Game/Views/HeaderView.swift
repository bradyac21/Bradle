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
        HStack {
            Button("How to Play", systemImage: "questionmark.circle") {
                AppState.shared.sheet = .howToPlay
            }
            
            Spacer()
            
            Text("BRADLE")
                .font(.custom(FontNames.bold, size: 17.5))
            
            Spacer()
            
            Button("Settings", systemImage: "gearshape.fill") {
                AppState.shared.sheet = .settings
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
