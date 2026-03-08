//
//  BradleAccount.swift
//  Bradle
//
//  Created by Brady Carden on 3/1/26.
//

struct BradleAccount {
    var gamesPlayed: Int
    var gamesWon: Int
    var guessHistory: [Int]
    
    init() {
        self.gamesPlayed = 8
        self.gamesWon = 8
        self.guessHistory = [3, 5, 5, 4, 5, 4, 2, 3]
    }
    
    func getGuessDistribution() -> Dictionary<Int, Int> {
        return Dictionary(grouping: guessHistory, by: { $0 }).mapValues { $0.count }
    }
}
