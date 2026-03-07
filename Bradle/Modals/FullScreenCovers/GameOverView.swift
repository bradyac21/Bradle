//
//  GameOverView.swift
//  Bradle
//
//  Created by Brady Carden on 2/10/26.
//

import SwiftUI

enum GameOverCase {
    case victory, fail
}

struct GameOverView: View {
    
    let gameOverCase: GameOverCase
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var gameRunner: GameRunner
    
    var body: some View {
        ZStack {
            BradleColors.dark.ignoresSafeArea()
            
            VStack {
                Divider()
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                    })
                    .padding()
                }
                Spacer()
                
                // Star thing
                StarThing()
                
                // Congratulations
                Text(gameOverCase == .victory ? Strings.victoryTitle : Strings.failTitle)
                    .font(.custom(FontNames.mainTitle, size: 40))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.bottom, 5)
                
                // Track message
                Text(gameOverCase == .victory ? Strings.victoryBody : Strings.failBody)
                    .font(.custom(FontNames.mediumFancy, size: 20))
                    .kerning(1)
                    .multilineTextAlignment(.center)
                    .lineSpacing(0)
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
                
                Spacer()
                    .frame(height: 40)
                
                Button(action: {
                    print("Share tapped")
                }, label: {
                    HStack {
                        Text("Create a free account")
                            .kerning(1)
                            .foregroundStyle(.primary)
                            .fontWeight(.semibold)
                            .font(.custom(FontNames.bold, size: 15))
                    }
                    .padding(.horizontal, 60)
                    .padding(.vertical, 15)
                    .background {
                        Capsule()
                            .foregroundStyle(.white)
                    }
                })
                .buttonStyle(.plain)
                .padding(.bottom, 10)
                
                // Already registered? button
                Button(action: {
                    print("Already Registered? Log In tapped")
                }, label: {
                    Text("Already Registered? Log In")
                        .font(.custom(FontNames.bold, size: 17.5))
                        .underline()
                        .foregroundStyle(.white)
                })
                .buttonStyle(.plain)
                .padding(.bottom, 30)
                
                Spacer()
                    .frame(height: 40)
                
                // Share Button
                Button(action: {
                    print("Share tapped")
                }, label: {
                    HStack {
                        Text("Share")
                            .foregroundStyle(.white)
                            .kerning(1)
                            .font(.custom(FontNames.bold, size: 17.5))
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(.white)
                        
                    }
                    .padding(.horizontal, 60)
                    .padding(.vertical, 10)
                    .background {
                        Capsule()
                            .foregroundStyle(.green)
                    }
                })
                .buttonStyle(.plain)
                Spacer()
            }
        }
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 1_000_000_000)
                gameRunner.hideKeyboard = true
            }
        }
    }
}

#Preview {
    GameOverView(gameOverCase: .fail)
        .environmentObject(GameRunner())
}
