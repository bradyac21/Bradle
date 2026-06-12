//
//  Badge.swift
//  Bradle
//
//  Created by Brady Carden on 6/10/26.
//

import SwiftUI

enum Badge: String, Hashable, Codable, CaseIterable {
    case fourteenDayStreak = "14-day Streak"
        case seaOfGreens = "Sea of Greens"
        case wordleIn2 = "Wordle in 2"
        case wordleIn1 = "Wordle in 1"
        case hardMode = "Hard Mode"
        case thirtyDayStreak = "30-day Streak"
        case thousandWordles = "1000 Wordles"
        case fifteenHundredWordles = "1500 Wordles"
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue.hashValue)
    }
    
    var allowsRepeat: Bool {
        switch self {
        case .fourteenDayStreak, .seaOfGreens, .wordleIn1, .wordleIn2, .hardMode, .thirtyDayStreak:
            return true
        case .thousandWordles, .fifteenHundredWordles:
            return false
        }
    }
    
    func isSatisified(account: BradleAccount, submittedAttempts: [SubmittedAttempt], hardModeEnabled: Bool) -> Bool {
        switch self {
        case .fourteenDayStreak:
            return account.currentStreak == 14

        case .seaOfGreens:
            return !submittedAttempts.flatMap { $0.statuses }.contains(.included)
            
        case .wordleIn2:
            return submittedAttempts.count == 2
            
        case .wordleIn1:
            return submittedAttempts.count == 1

        case .hardMode:
            return hardModeEnabled

        case .thirtyDayStreak:
            return account.currentStreak == 30

        case .thousandWordles:
            return account.gamesWon == 1000

        case .fifteenHundredWordles:
            return account.gamesWon == 1500
        }
    }
}

extension Badge {
    @ViewBuilder
    var icon: some View {
        switch self {
        case .fourteenDayStreak:
            FourteenDayStreakBadge()
        case .seaOfGreens:
            SeaOfGreensBadge()
        case .wordleIn2:
            WordleInTwo()
        case .wordleIn1:
            WordleInOne()
        case .hardMode:
            HardModeBadge()
        case .thirtyDayStreak:
            ThirtyDayStreakBadge()
        case .thousandWordles:
            ThousandWordlesBadge()
        case .fifteenHundredWordles:
            FifteenHundredWordlesBadge()
        }
    }
}

class BadgeManager {
    var account: BradleAccount
    var gameRunner: GameRunner
    
    init(account: BradleAccount, gameRunner: GameRunner) {
        self.account = account
        self.gameRunner = gameRunner
    }
}
