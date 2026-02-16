//
//  CurrentAttempt.swift
//  Bradle
//
//  Created by Brady Carden on 1/25/26.
//

struct CurrentAttempt: Attempt {
    var attempt: [Letter]
    var length: Int
    var animateError: Bool

    init() {
        self.attempt = Array(repeating: .empty, count: 5)
        self.length = 0
        self.animateError = false
    }
    
    mutating func backspace() {
        // Make sure there is something to delete
        guard length != 0 else { return }
        
        attempt[length - 1] = .empty
        length -= 1
    }
    
    mutating func addLetter(_ letter: Letter) {
        // Make sure attempt is not full
        guard length != 5 else { return }
        
        attempt[length] = letter
        length += 1
    }
}
