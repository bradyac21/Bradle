//
//  BradleAccount.swift
//  Bradle
//
//  Created by Brady Carden on 3/1/26.
//

import SwiftData
import Foundation

@Model
class BradleAccount {
    var id: UUID
    var username: String
    var password: String
    var gamesPlayed: Int
    var gamesWon: Int
    var guessDistribution: [Int: Int]
    var currentStreak: Int
    var maxStreak: Int
    var guessHistory: [Int]
    var nextWordIndex: Int
    var lastWonGameDate: Date
    var badges: [String: Int]
    
    var winPercent: Int {
        guard gamesPlayed != 0 else {
            return 0
        }
        
        return Int((Double(gamesWon) / Double(gamesPlayed)) * 100)
    }
    
    init(username: String, password: String) {
        self.id = UUID()
        self.username = username
        self.password = password
        self.gamesPlayed = 0
        self.gamesWon = 0
        self.guessDistribution = [:]
        self.currentStreak = 0
        self.maxStreak = 0
        self.guessHistory = []
        self.nextWordIndex = 0
        self.lastWonGameDate = .distantPast
        self.badges = [:]
    }
    
    init(
        username: String,
        password: String,
        gamesPlayed: Int,
        gamesWon: Int,
        currentStreak: Int,
        maxStreak: Int,
        guessHistory: [Int],
        guessDistribution: [Int: Int],
        nextWordIndex: Int,
        lastWonGameDate: Date,
        badges: [String: Int]
    ) {
        self.id = UUID()
        self.username = username
        self.password = password
        self.gamesPlayed = gamesPlayed
        self.gamesWon = gamesWon
        self.currentStreak = currentStreak
        self.maxStreak = maxStreak
        self.guessHistory = guessHistory
        self.guessDistribution = guessDistribution
        self.nextWordIndex = nextWordIndex
        self.lastWonGameDate = lastWonGameDate
        self.badges = badges
    }
    
    func handleFinishedGame(success: Bool, submittedAttempts: [SubmittedAttempt], hardModeEnabled: Bool) {
        // allows you to play more than 1 game a day, doesn't save results past first play
        guard !Calendar.current.isDateInToday(lastWonGameDate) else { return }
        
        nextWordIndex = (nextWordIndex + 1) % Constants.words.count
        gamesPlayed += 1
        
        if success {
            gamesWon += 1
            guessHistory.append(submittedAttempts.count)
            guessDistribution[submittedAttempts.count] = 1 + (guessDistribution[submittedAttempts.count] ?? 0)
            currentStreak += 1
            maxStreak = max(maxStreak, currentStreak)
            lastWonGameDate = Date.now
            
            for badge in Badge.allCases {
                if badge.isSatisified(account: self, submittedAttempts: submittedAttempts, hardModeEnabled: hardModeEnabled) {
                    if self.badges[badge.rawValue] == nil {
                        self.badges[badge.rawValue] = 1
                    } else {
                        // unwrap should be redundant
                        self.badges[badge.rawValue] = self.badges[badge.rawValue] ?? 0 + 1
                    }
                }
            }
        }
        
        
    }
    
    static let testAccount =
        BradleAccount(
            username: "Test User",
            password: "testuser",
            gamesPlayed: 89,
            gamesWon: 82,
            currentStreak: 13,
            maxStreak: 14,
            guessHistory: [1, 2] + Array(repeating: 3, count: 12) + Array(repeating: 4, count: 26) + Array(repeating: 5, count: 27) + Array(repeating: 6, count: 15),
            guessDistribution: [1:1, 2:1, 3:12, 4:26, 5:27, 6:15],
            nextWordIndex: 5,
            lastWonGameDate: Date.now,
            badges: [Badge.seaOfGreens.rawValue: 14, Badge.hardMode.rawValue: 3, Badge.wordleIn1.rawValue: 1, Badge.wordleIn2.rawValue: 4]
        )
    
}
