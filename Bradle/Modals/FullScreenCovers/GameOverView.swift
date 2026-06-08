////
////  GameOverView.swift
////  Bradle
////
////  Created by Brady Carden on 2/10/26.
////
//
//import SwiftUI
//
//struct GameOverView: View {
//    
//    let gameOverCase: GameOverCase
//    
//    @Environment(\.dismiss) var dismiss
//    @Environment(GameRunner.self) var gameRunner
//    
//    var body: some View {
//        ZStack {
//            BradleColors.dark.ignoresSafeArea()
//            
//            VStack {
//                Button("Dismiss", systemImage: "xmark") {
//                    dismiss()
//                }
//                .buttonStyle(.plain)
//                .labelStyle(.iconOnly)
//                .foregroundStyle(.white)
//                .padding()
//                .frame(maxWidth: .infinity, alignment: .trailing)
//                
//                Spacer()
//                
//                StarThing()
//                
//                Text(gameOverCase.title)
//                    .font(.custom(FontNames.mainTitle, size: 40))
//                    .multilineTextAlignment(.center)
//                    .foregroundStyle(.white)
//                    .padding(.bottom, 5)
//                
//                Text(gameOverCase.body)
//                    .font(.custom(FontNames.mediumFancy, size: 20))
//                    .kerning(1)
//                    .multilineTextAlignment(.center)
//                    .foregroundStyle(.white)
//                    .padding(.bottom, 10)
//                
//                Spacer()
//                    .frame(height: 40)
//                
//                BradleButton("Create a free account", fillColor: .white, size: .large) {
//                    print("Share tapped")
//                }
//                .font(.custom(FontNames.bold, size: 15))
//                .padding(.bottom, 10)
//
//                
//                Button("Already Registered? Log In") {
//                    print("Already registered tapped")
//                }
//                .font(.custom(FontNames.bold, size: 17.5))
//                .underline()
//                .foregroundStyle(.white)
//                .buttonStyle(.plain)
//                .padding(.bottom, 30)
//                
//                Spacer()
//                    .frame(height: 40)
//                
//                ShareLink(item: gameRunner.textRepresentation()) {
//                    HStack {
//                        Text("Share")
//                            .font(.custom(FontNames.bold, size: 17.5))
//                        Image(systemName: "square.and.arrow.up")
//                        
//                    }
//                }
//                .buttonStyle(BradleButtonStyle(textColor: .white, fillColor: BradleColors.green))
//                
//                Spacer()
//            }
//        }
//        .onAppear {
//            Task {
//                try await Task.sleep(nanoseconds: 1_000_000_000)
//                gameRunner.hideKeyboard = true
//            }
//        }
//    }
//}
//
//#Preview {
//    GameOverView(gameOverCase: .fail)
//        .environment(GameRunner())
//}
