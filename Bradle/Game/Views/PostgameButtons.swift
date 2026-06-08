//
//  PostgameButtons.swift
//  Bradle
//
//  Created by Brady Carden on 2/14/26.
//

import SwiftUI

struct PostgameButtons: View {
    
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        VStack {
            
            // TODO: Need to get the case somehow
            PostgameButton(label: "See results", fill: false) {
                AppState.shared.fullScreenCover = .results(.fail)
            }
            
            Spacer()
                .frame(height: 10)
            
            PostgameButton(label: "Play the Bradle Archive", fill: false) {
                // TODO: Implement Bradle Archive
                print("Play the Bradle Archive Tapped")
            }
        }
    }
}

#Preview {
    ZStack {
        BradleColors.darkModeBackground.ignoresSafeArea()
        PostgameButtons()
            .environment(GameRunner())
            .environment(ColorManager())
    }
}

struct PostgameButton: View {
    let label: String
    let fill: Bool
    let action: () -> ()
    
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(fill ?  colorManager.primary : .clear)
                    .stroke(colorManager.primary)
                    .frame(width: 250, height: 40)
                
                Text(label)
                    .font(.custom(FontNames.bold, size: 16))
                    .foregroundStyle(fill ? colorManager.secondary : colorManager.primary)
                    .padding(.bottom, 2)
            }
        }
        .buttonStyle(.plain)
    }
}
