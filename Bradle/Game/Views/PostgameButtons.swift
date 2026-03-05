//
//  PostgameButtons.swift
//  Bradle
//
//  Created by Brady Carden on 2/14/26.
//

import SwiftUI

struct PostgameButtons: View {
    
    @EnvironmentObject var gameRunner: GameRunner
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                gameRunner.fullScreenCover = .results
            }, label: {
                Text("See results")
                    .foregroundStyle(colorManager.textColor)
                    .padding(.horizontal, 87)
                    .padding(.vertical, 8)
                    .background {
                        Capsule()
                            .stroke(colorManager.textColor)
                    }
            })
            .buttonStyle(.plain)
            .padding(.bottom, 5)
            
            Button(action: {
                print("Play the Bradle Archive tapped")
            }, label: {
                Text("Play the Bradle Archive")
                    .foregroundStyle(colorManager.textColor)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 8)
                    .background {
                        Capsule()
                            .stroke(colorManager.textColor)
                    }
            })
            .buttonStyle(.plain)
            Spacer()
        }
    }
}
