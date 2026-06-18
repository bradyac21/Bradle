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
    
    func description(earnedCount: Int) -> String {
        
        var res = earnedCount == 0 ? "Earn " : "You earned "
        switch self {
            
        case .fourteenDayStreak:
            res += "this badge \(earnedCount > 1 ? "\(earnedCount) times " : "")by completing 14 consecutive daily Wordle puzzles without losing."
        case .seaOfGreens:
            res += "this badge \(earnedCount > 1 ? "\(earnedCount) times " : "")by successfully completing a Wordle puzzle while only getting green and gray letters (or orange and gray letters if playing in high contrast mode)"
        case .wordleIn2:
            res += "this badge \(earnedCount > 1 ? "\(earnedCount) times " : "")by solving a World puzzle in 2 guesses."
        case .wordleIn1:
            res += "this badge \(earnedCount > 1 ? "\(earnedCount) times " : "")by solving a Wordle puzzle in 1 guess."
        case .hardMode:
            res += "this badge \(earnedCount > 1 ? "\(earnedCount) times " : "")by successfully completing a Wordle puzzle in Hard Mode. Turn on Hard Mode in Wordle's settings menu."
        case .thirtyDayStreak:
            res += "this badge \(earnedCount > 1 ? "\(earnedCount) times " : "")by completing 30 consecutive daily Wordle puzzles without losing."
        case .thousandWordles:
            res += "this badge\(earnedCount > 1 ? "\(earnedCount) times " : "") by completing 1000 Wordle puzzles, on any date, win or lose."
        case .fifteenHundredWordles:
            res += "this badge \(earnedCount > 1 ? "\(earnedCount) times " : "")by completing 1500 Wordle puzzles, on any date, win or lose."
        }
        
        return res
    }
    
    var targetVal: Int {
        switch self {
        case .fourteenDayStreak: 14
        case .thirtyDayStreak: 30
        case .thousandWordles: 1000
        case .fifteenHundredWordles: 1500
        default: 1
        }
    }
    
    var badgeProgess: (currentProgress: Int, targetVal: Int)? {
        guard let account = AccountStore.shared.account else { return nil }
        
        switch self {
        case .fourteenDayStreak, .thirtyDayStreak:
            return (account.currentStreak, self.targetVal)
        case .thousandWordles, .fifteenHundredWordles:
            return (account.gamesWon, self.targetVal)
        
        // Single game badges, no progress
        case .seaOfGreens, .wordleIn1, .wordleIn2, .hardMode:
            return nil
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
            return account.gamesPlayed == 1000

        case .fifteenHundredWordles:
            return account.gamesPlayed == 1500
        }
    }
}

extension Badge {
    @ViewBuilder
    func icon(size: BadgeSize = .small) -> some View {
        switch self {
        case .fourteenDayStreak:
            FourteenDayStreakBadge(size: size)
        case .seaOfGreens:
            SeaOfGreensBadge(size: size)
        case .wordleIn2:
            WordleInTwoBadge(size: size)
        case .wordleIn1:
            WordleInOneBadge(size: size)
        case .hardMode:
            HardModeBadge(size: size)
        case .thirtyDayStreak:
            ThirtyDayStreakBadge(size: size)
        case .thousandWordles:
            ThousandWordlesBadge(size: size)
        case .fifteenHundredWordles:
            FifteenHundredWordlesBadge(size: size)
        }
    }
    
    @ViewBuilder
    func pulseIcon(size: BadgeSize = .large) -> some View {
        switch self {
            
        case .fourteenDayStreak:
            FourteenDayStreakPulseBadge(size: size)
        case .seaOfGreens:
            SeaOfGreensPulseBadge(size: size)
        case .wordleIn2:
            WordleInOnePulseBadge(size: size)
        case .wordleIn1:
            WordleInOnePulseBadge(size: size)
        case .hardMode:
            HardModeBadge(size: size)
        case .thirtyDayStreak:
            ThirtyDayStreakPulseBadge(size: size)
        case .thousandWordles:
            ThousandWordlesPulseBadge(size: size)
        case .fifteenHundredWordles:
            FifteenHundredWordlesPulseBadge(size: size)
        }
    }
}
