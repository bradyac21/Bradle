//
//  ResultsView.swift
//  Bradle
//
//  Created by Brady Carden on 3/1/26.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(GameRunner.self) var gameRunner
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    let gameOverCase: GameOverCase
    
    var body: some View {
        ScrollView {
            
            Button("Back to puzzle", systemImage: "xmark") {
                dismiss()
            }
            .labelStyle(.iconOnly)
            .buttonStyle(.plain)
            .foregroundStyle(darkModeEnabled ? .white : .black)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            if !AccountStore.isLoggedIn {
                Spacer()
                    .containerRelativeFrame(.vertical) { height, _ in
                        height * 0.15
                    }
            }
            
            StarThing()
            
            // Congratulations
            Text(gameOverCase.title)
                .font(.custom(FontNames.mainTitle, size: 40))
                .padding(.bottom, 5)
            
            if !AccountStore.isLoggedIn {
                Text(gameOverCase.body)
                    .font(.custom(FontNames.mediumFancy, size: 20))
                    .kerning(1)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
            }
            
            
            if let account = AccountStore.shared.account {
                
                // Stats label
                Text("STATISTICS")
                    .font(.custom(FontNames.bold, size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                
                // Statistics
                HStack(alignment: .center) {
                    StatView(stat: Stat(account.gamesPlayed, "Played"))
                    StatView(stat: Stat(account.winPercent, "Win %"))
                    StatView(stat: Stat(account.currentStreak, "Current Streak"))
                    StatView(stat: Stat(account.maxStreak, "Max Streak"))
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom)
                
                Text("GUESS DISTRIBUTION")
                    .font(.custom(FontNames.bold, size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                GuessDistView(recentGuess: gameRunner.recentGameGuessIndex)
                    .padding(.bottom)
                
            } else {
                BradleButton("Create a free account", fillColor: .white, size: .large) {
                    AppState.shared.sheet = .login(.createAccount)
                }
                .font(.custom(FontNames.bold, size: 15))
                .padding(.bottom, 10)
                
                
                Button("Already Registered? Log In") {
                    AppState.shared.sheet = .login(.login)
                }
                .font(.custom(FontNames.bold, size: 17.5))
                .underline()
                .foregroundStyle(.white)
                .buttonStyle(.plain)
                
                Spacer()
                    .frame(height: 40)
            }
            
            ShareLink(item: gameRunner.textRepresentation()) {
                HStack {
                    Text("Share")
                        .font(.custom(FontNames.bold, size: 17.5))
                    Image(systemName: "square.and.arrow.up")
                    
                }
            }
            .buttonStyle(BradleButtonStyle(textColor: .white, fillColor: BradleColors.green))
            .padding(.top, 20)
            
            Spacer()
            
            // Custom puzzle, share
            
            // Share button
            
            // Explore wordle archive
            
            Spacer()
        }
        .foregroundStyle(darkModeEnabled ? .white : .black)
        .padding()
        .multilineTextAlignment(.center)
        .background {
            darkModeEnabled ? BradleColors.darkModeBackground.ignoresSafeArea() : BradleColors.lightModeBackground.ignoresSafeArea()
        }
        .onAppear {
                    Task {
                        try await Task.sleep(nanoseconds: 500_000_000)
                        gameRunner.hideKeyboard = true
                    }
                }
    }
}

#Preview {
    ResultsView(gameOverCase: .fail)
        .environment(GameRunner())
        .environment(ColorManager())
}

struct Stat: Hashable {
    let value: Int
    let label: String
    
    init(_ value: Int, _ label: String) {
        self.value = value
        self.label = label
    }
}

struct StatView: View {
    let stat: Stat
    var body: some View {
        VStack {
            Text(stat.value.description)
                .font(.custom(FontNames.mediumFancy, size: 30))
                .frame(height: 30)
            Text(stat.label)
                .font(.custom(FontNames.mediumFancy, size: 15))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .frame(height: 40, alignment: .top)
        }
        .frame(width: 75)
    }
}

struct GuessDistView: View {
    
    let recentGuess: Int?
    var account: BradleAccount? = AccountStore.shared.account
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(1..<7) { index in
                HStack {
                    Text(index.description)
                        .font(.custom(FontNames.mediumFancy, size: 15))
                        .frame(width: 10)
                        .bold()
                    Rectangle()
                        .fill(index == recentGuess ? BradleColors.green : BradleColors.darkModeFilledBorder)
                        .containerRelativeFrame(.horizontal) { width, _ in
                            if let indexWinTotal = account?.guessDistribution[index], let histMax = account?.guessDistribution.values.max() {
                                let factor = Float(indexWinTotal) / (Float(histMax) * 1.25)
                                return 10 + width * CGFloat(factor)
                            } else {
                                return 20
                            }
                        }
                    
                        .overlay {
                            Text((account?.guessDistribution[index] ?? 0).description)
                                .font(.custom(FontNames.mediumFancy, size: 15))
                                .bold()
                                .padding(.trailing, 6)
                                .padding(.top, 1)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                }
                .frame(height: 20)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

enum GameOverCase: Equatable {
    case victory(Int), fail
    
    var title: String {
        switch self {
        case .victory: Strings.victoryTitle
        case .fail: Strings.failTitle
        }
    }
    
    var body: String {
        switch self {
        case .victory: Strings.victoryBody
        case .fail: Strings.failBody
        }
    }
}
