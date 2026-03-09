//
//  Attempt.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import Foundation

struct SubmittedAttempt: Identifiable, Hashable, Codable {
    let id = UUID()
    var letters: [Letter]
    var statuses: [SubmittedStatus]
    var isTarget: Bool
    
    var letterStatuses: [(Letter, SubmittedStatus)] {
        Array(zip(letters, statuses))
    }
    
    /// Default init for testing and previews
    init() {
        self.letters = [.R, .O, .G, .U, .E]
        self.statuses = [.correct, .included, .notIncluded, .notIncluded, .included]
        self.isTarget = true
    }
    
    init(letter: [Letter], statuses: [SubmittedStatus], isTarget: Bool = false) {
        self.letters = letter
        self.statuses = statuses
        self.isTarget = isTarget
    }
}
