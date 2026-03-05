//
//  HeaderView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var gameRunner: GameRunner
    @Environment(ColorManager.self) var colorManager
    
    public var body: some View {
        HStack {
            Button(action: {
                gameRunner.sheet = .howToPlay
            }, label: {
                Image(systemName: "questionmark.circle")
            })
            Spacer()
            Text("BRADLE")
                .font(.headline)
            Spacer()
            Button(action: {
                gameRunner.sheet = .settings
            }, label: {
                Image(systemName: "gear")
            })
        }
        .foregroundStyle(colorManager.textColor)
    }
}

#Preview {
    HeaderView()
        .background(BradleColors.darkModeBackground)
        .environmentObject(GameRunner())
        .environment(ColorManager())
}
