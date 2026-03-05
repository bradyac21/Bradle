//
//  VictoryScreen.swift
//  Bradle
//
//  Created by Brady Carden on 2/10/26.
//

import SwiftUI

struct VictoryScreen: View {
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
                Text("Congratulations!")
                    .font(.custom(FontNames.mainTitle, size: 40))
                    .foregroundStyle(.white)
                    .padding(.bottom, 5)
                
                // Track message
                Text("Track your Bradle win\npercentage and earn\nbadges for big\nachievements.")
                    .font(.custom(FontNames.mediumFancy, size: 20))

                    .multilineTextAlignment(.center)
                    .kerning(1)
                    .lineSpacing(0)
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
                
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
    VictoryScreen()
        .environmentObject(GameRunner())
}
