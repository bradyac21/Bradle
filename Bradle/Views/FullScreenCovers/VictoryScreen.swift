//
//  VictoryScreen.swift
//  Bradle
//
//  Created by Brady Carden on 2/10/26.
//

import SwiftUI

struct VictoryScreen: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            darkBackground.ignoresSafeArea()
            
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
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 80)
                        .foregroundStyle(.green)
                        .opacity(0.5)
                    RoundedRectangle(cornerRadius: 0)
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 50)
                        .foregroundStyle(.green)
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .foregroundStyle(.white)
                        .frame(width: 40)
                }
                
                // Congratulations
                Text("Congratulations!")
                    .font(.karnakCondensedBold)
                    .foregroundStyle(.white)
                    .padding(.bottom, 5)
                
                // Track message
                Text("Track your Bradle win\npercentage and earn\nbadges for big\nachievements.")
                    .font(.cheltenhamExtraLight)
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
                            .font(.system(size: 15))
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
                        .fontWeight(.semibold)
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
                            .fontWeight(.semibold)
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
    }
}

#Preview {
    VictoryScreen()
}
