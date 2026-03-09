//
//  StartView.swift
//  Bradle
//
//  Created by Brady Carden on 2/9/26.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var gameRunner: GameRunner
    
    var body: some View {
        ZStack {
            BradleColors.lightModeBackground.ignoresSafeArea()
#if DEBUG
                .simultaneousGesture(
                    TapGesture(count: 3)
                        .onEnded {
                            gameRunner.fullScreenCover = .testing
                        }
                )
#endif
            VStack {
                Spacer()
                // Bradle logo
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                // Bradle title
                Text("Bradle")
                    .font(.custom(FontNames.mainTitle, size: 30))
                    .padding(.vertical, 10)
                
                // Get 6 chances to guess a
                // 5-letter word.
                Text("Get 6 chances to guess a\n 5-letter word.")
                    .lineSpacing(8)
                    .multilineTextAlignment(.center)
                    .font(.custom(FontNames.cowboy, size: 20))
                    .padding(.bottom)
                
                
                // Play button
                BradleButton("Play", fill: true) {
                    gameRunner.location = .game
                }
                
                // Log in
                BradleButton("Log in") {
                    gameRunner.sheet = .login
                }
                
                // Subscribe
                BradleButton("Subscribe") {
                    print("Subscribe tapped")
                }
                
                Spacer()
                
                // Date
                Text(Date().formatted(date: .long, time: .omitted))
                Text("Created by Brady Carden")
                    .fontWeight(.light)
                    .font(.system(size: 15))
                
                Spacer()
            }
            .onAppear {
                let account = BradleAccount(
                    username: "test_username",
                    password: "test_password",
                    gamesPlayed: 12,
                    gamesWon: 12,
                    winPercentage: 1,
                    currentStreak: 1,
                    longestStreak: 4,
                    guessDistribution: [1:0, 2:0, 3:3, 4:3, 5:6, 6:0],
                    gameHistory: [
                        CompletedGame(date: date1, submittedAttempts: submittedAttempts, won: true),
                        CompletedGame(date: date2, submittedAttempts: submittedAttempts, won: true),
                        CompletedGame(date: date3, submittedAttempts: submittedAttempts, won: true),
                        CompletedGame(date: date4, submittedAttempts: submittedAttempts, won: true),
                        CompletedGame(date: date5, submittedAttempts: submittedAttempts, won: true),
                        CompletedGame(date: date6, submittedAttempts: submittedAttempts, won: true),
                        CompletedGame(date: date7, submittedAttempts: submittedAttempts, won: true),
                        CompletedGame(date: date8, submittedAttempts: submittedAttempts, won: true),
                        CompletedGame(date: date9, submittedAttempts: submittedAttempts, won: true),
                        CompletedGame(date: date10, submittedAttempts: submittedAttempts, won: true),
                        CompletedGame(date: date11, submittedAttempts: submittedAttempts, won: true),
                        CompletedGame(date: date12, submittedAttempts: submittedAttempts, won: true),]
                )
                
                FakeServer.shared.saveAccountData(for: account)
            }
        }
    }
}

#Preview {
    StartView()
        .environmentObject(GameRunner())
}

struct BradleButton: View {
    var label: String
    var fill: Bool = false
    var action: () -> Void
    
    init(_ label: String, fill: Bool = false, action: @escaping () -> Void) {
        self.label = label
        self.fill = fill
        self.action = action
    }
    
    var body: some View {
        Text(label)
            .foregroundStyle(fill ? .white : BradleColors.introDark)
            .frame(width: 150, height: 20)
            .padding(.vertical, 12.5)
            .background {
                Capsule()
                    .stroke(BradleColors.dark, lineWidth: 2)
                    .fill(fill ? BradleColors.introDark : BradleColors.lightModeBackground)
            }
            .onTapGesture {
                action()
            }
           
    }
}


let submittedAttempts = [SubmittedAttempt()]
let date1: Date = Calendar.current.date(byAdding: .day, value: 0, to: Date.now)!
let date2 = Calendar.current.date(byAdding: .day, value: -2, to: Date.now)!
let date3 = Calendar.current.date(byAdding: .day, value: -3, to: Date.now)!
let date4 = Calendar.current.date(byAdding: .day, value: -5, to: Date.now)!
let date5 = Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!
let date6 = Calendar.current.date(byAdding: .day, value: -8, to: Date.now)!
let date7 = Calendar.current.date(byAdding: .day, value: -9, to: Date.now)!
let date8 = Calendar.current.date(byAdding: .day, value: -10, to: Date.now)!
let date9 = Calendar.current.date(byAdding: .day, value: -12, to: Date.now)!
let date10 = Calendar.current.date(byAdding: .day, value: -14, to: Date.now)!
let date11 = Calendar.current.date(byAdding: .day, value: -15, to: Date.now)!
let date12 = Calendar.current.date(byAdding: .day, value: -16, to: Date.now)!
