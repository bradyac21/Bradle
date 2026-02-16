//
//  GameView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var bradleViewModel: BradleViewModel
    
    var body: some View {
        GeometryReader { geometry in

                VStack(alignment: .center, spacing: 0) {
                    HeaderView()
                        .frame(width: geometry.size.width * 0.95, height: geometry.size.width * 0.15)
                    
                    Divider()
                    Spacer()
                    Text(bradleViewModel.alertMessage)
                        .foregroundStyle(.white)
                    Spacer()
                    
                    AttemptsView()
                        .frame(height: geometry.size.height * 0.5)
                        .frame(width: geometry.size.width * 0.75)
                    
                    Spacer()
                    
                    if !bradleViewModel.hideKeyboard {
                        KeyboardView()
                            .frame(height: geometry.size.height * 0.25)
                    } else {
                        PostgameButtons()
                            .frame(height: geometry.size.height * 0.25)
                    }
                }

        }
        .background(darkBackground)
        .environmentObject(bradleViewModel)
    }
}

#Preview {
    GameView()
        .environmentObject(BradleViewModel())
}
