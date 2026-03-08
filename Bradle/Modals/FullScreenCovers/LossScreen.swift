//
//  LossScreen.swift
//  Bradle
//
//  Created by Brady Carden on 3/5/26.
//

import SwiftUI

struct LossScreen: View {
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        
        ZStack {
            colorManager.gameBackground.ignoresSafeArea()
            
            VStack {
                StarThing()
                
                Text("Thanks for playing\n today!")
                    .font(.custom(FontNames.mainTitle, size: 35))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
                
                Text("Want to follow friends' daily\nscores, track stats and more?")
                    .font(.custom(FontNames.mediumFancy, size: 20))
                    .kerning(1)
                
                PostgameButton(label: "Create a free account", fill: true) {
                    print("Create a free acount clicked")
                }
                
            }
            .foregroundStyle(colorManager.primary)
        }
    }
}

#Preview {
    LossScreen()
        .environment(ColorManager())
}
