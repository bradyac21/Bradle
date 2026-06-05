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
    var rememberMe: Bool
    
    var winPercent: Int {
        Int((Double(gamesWon) / Double(gamesPlayed)) * 100)
    }
    
    init(username: String, password: String) {
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
        self.rememberMe = true
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
        rememberMe: Bool
    ) {
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
        self.rememberMe = rememberMe
    }
    
    func handleFinishedGame(success: Bool, numAttempts: Int) {
        // allows you to play more than 1 game a day, doesn't save results past first play
        guard !Calendar.current.isDateInToday(lastWonGameDate) else { return }
        
        nextWordIndex = (nextWordIndex + 1) % Constants.words.count
        gamesPlayed += 1
        
        if success {
            gamesWon += 1
            guessHistory.append(numAttempts)
            guessDistribution[numAttempts] = 1 + (guessDistribution[numAttempts] ?? 0)
            currentStreak += 1
            maxStreak = max(maxStreak, currentStreak)
            lastWonGameDate = Date.now
        }
    }
}
