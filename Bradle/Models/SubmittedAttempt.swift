//
//  Attempt.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

struct SubmittedAttempt: Attempt, Hashable {
    var attempt: [Letter]
    var statuses: [Status]
    
    init() {
        attempt = Array(repeating: .empty, count: 5)
        statuses = Array(repeating: .notTried, count: 5)
    }
    
    init(attempt: [Letter], statuses: [Status]) {
        self.attempt = attempt
        self.statuses = statuses
    }
}
