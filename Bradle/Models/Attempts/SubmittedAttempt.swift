//
//  Attempt.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

struct SubmittedAttempt: Hashable {
    var attempt: [Letter]
    var statuses: [Status]
    var isTarget: Bool
    
    /// Default init for testing and previews
    init() {
        self.attempt = [.R, .O, .G, .U, .E]
        self.statuses = [.correct, .included, .notIncluded, .notIncluded, .included]
        self.isTarget = true
    }
    
    init(attempt: [Letter], statuses: [Status], isTarget: Bool = false) {
        self.attempt = attempt
        self.statuses = statuses
        self.isTarget = isTarget
    }
}

struct SubmittedAttempt2: Hashable {
    var attempt: [Letter]
    var statuses: [Status2]
    var isTarget: Bool
    
    /// Default init for testing and previews
    init() {
        self.attempt = [.R, .O, .G, .U, .E]
        self.statuses = [.correct, .included, .notIncluded, .notIncluded, .included]
        self.isTarget = true
    }
    
    init(attempt: [Letter], statuses: [Status2], isTarget: Bool = false) {
        self.attempt = attempt
        self.statuses = statuses
        self.isTarget = isTarget
    }
}
