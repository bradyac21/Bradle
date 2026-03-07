//
//  AlertMessage.swift
//  Bradle
//
//  Created by Brady Carden on 2/10/26.
//

import Foundation

enum AlertMessage {
    case notInWordList
    case notEnoughLetters
    case fail
    case word(String)
    case empty
    case cannotEnableHardMode
    
    case unsatisfiedHint(Hint)
    
    case victoryIn1
    case victoryIn2
    case victoryIn3
    case victoryIn4
    case victoryIn5
    case victoryIn6
    
    var string: String {
        switch self {
            
        case .notInWordList: "Not in Word List"
        case .notEnoughLetters: "Not Enough Letters"
        case .fail: "Maybe next time"
        case .word(let word): word
        case .empty: ""
            
        case .cannotEnableHardMode: "Hard mode can only be enabled at the start of a round"
            
        case .unsatisfiedHint(let hint): getUnsatisfiedHintMessage(for: hint)
            
        case .victoryIn1: "Perfection!"
        case .victoryIn2: "Exquisite!"
        case .victoryIn3: "Nice!"
        case .victoryIn4: "Good job!"
        case .victoryIn5: "Finally!"
        case .victoryIn6: "That was close!"
        }
    }
    
    // Must be 6 elements
    static var victoryMessages: [AlertMessage] = [.victoryIn1, .victoryIn2, .victoryIn3, .victoryIn4, .victoryIn5, .victoryIn6]
    
    func getUnsatisfiedHintMessage(for hint: Hint) -> String {
        if let location = hint.location {
            
            // Setup formatter to get "st", "nd", "rd", or "th"
            let formatter = NumberFormatter()
            formatter.numberStyle = .ordinal
            
            // Build alert string
            if let formattedNumber = formatter.string(from: location + 1 as NSNumber) {
                return "\(formattedNumber) letter must be \(hint.letter)"
            }
            
        } else {
            return "Guess must contain \(hint.letter)"
        }
        
        // Fall back string, used when formatterNumber fails
        // Should never be used
        return "Must satisfy all hints"
    }
}
