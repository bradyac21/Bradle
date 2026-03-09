//
//  BradleAccount.swift
//  Bradle
//
//  Created by Brady Carden on 3/1/26.
//

import Foundation

struct BradleAccount: Codable {
    
    /// Username of the account
    let username: String
    
    /// Password for the account
    let password: String
    
    /// Number that stores the number of completed games by a user
    var gamesPlayed: Int
    
    /// Number that stores the number of games won of the completed games
    var gamesWon: Int
    
    /// Percetange of games won - maybe should be a computed property
    var winPercentage: Float
    
    /// Current number of games won in a row without missing a day
    var currentStreak: Int {
        didSet {
            longestStreak = max(longestStreak, currentStreak)
        }
    }
    
    /// Longest instance of the above
    var longestStreak: Int
    
    /// Stores the number of games won for each number of guesses
    var guessDistribution: [Int: Int]
    
    /// Stores the final game boards of each completed game - maybe not needed
    var gameHistory: [CompletedGame]
    
    /// Parameterized init
    init(username: String, password: String, gamesPlayed: Int, gamesWon: Int, winPercentage: Float, currentStreak: Int, longestStreak: Int, guessDistribution: [Int : Int], gameHistory: [CompletedGame]) {
        self.username = username
        self.password = password
        self.gamesPlayed = gamesPlayed
        self.gamesWon = gamesWon
        self.winPercentage = winPercentage
        self.currentStreak = currentStreak
        self.longestStreak = longestStreak
        self.guessDistribution = guessDistribution
        self.gameHistory = gameHistory
    }
    
    /// Empty init - sets all values to empty
    init(username: String, password: String) {
        self.username = username
        self.password = password
        self.gamesPlayed = 0
        self.gamesWon = 0
        self.winPercentage = 0
        self.currentStreak = 0
        self.longestStreak = 0
        self.guessDistribution = [1 : 0, 2 : 0, 3 : 0, 4 : 0, 5 : 0, 6 : 0]
        self.gameHistory = []
    }
    
    mutating func addGame(_ game: CompletedGame) {
        
        // Update games played and games won
        self.gamesPlayed += 1
        if game.won {
            self.gamesWon += 1
        }

        // Update streak
        // Unwrap date from the last game
        if let lastGameDate = gameHistory.last?.date {
            let calendar = Calendar.current
            
            // Use calendar to make comparisons easier
            let lastDate = calendar.startOfDay(for: lastGameDate)
            let currentGameDate = calendar.startOfDay(for: game.date)
            
            // If the days are adjacent, update the streak
            if calendar.dateComponents([.day], from: lastDate, to: currentGameDate).day == 1 {
                self.currentStreak += 1
            }
        
        // If game history is empty (first game) or dates were not adjacent
        } else {
            self.currentStreak = 1
        }
        
        // update guess history
        self.guessDistribution[safeKey: game.submittedAttempts.count] += 1
        
        // add to game history
        self.gameHistory.append(game)
    }
}

// Used to make working with guessDistribution easier
private extension Dictionary where Key == Int, Value == Int {
    subscript(safeKey key: Int) -> Int {
        get { self[key] ?? 0 }
        set {
            // Make sure key is valid
            if key >= 1 && key <= 6 {
                self[key] = newValue
            }
        }
    }
}

struct CompletedGame: Codable {
    let date: Date
    let submittedAttempts: [SubmittedAttempt]
    let won: Bool
    
    init(submittedAttempts: [SubmittedAttempt], won: Bool) {
        self.date = Date.now
        self.submittedAttempts = submittedAttempts
        self.won = won
    }
    
    init(date: Date, submittedAttempts: [SubmittedAttempt], won: Bool) {
        self.date = date
        self.submittedAttempts = submittedAttempts
        self.won = won
    }
}
