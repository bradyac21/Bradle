//
//  AlertMessage.swift
//  Bradle
//
//  Created by Brady Carden on 2/10/26.
//

enum AlertMessage {
    case notInWordList
    case notEnoughLetters
    case fail
    
    var message: String {
        switch self {
            
        case .notInWordList:
            "Not in Word List"
        case .notEnoughLetters:
            "Not Enough Letters"
        case .fail:
            "Maybe next time"
        }
    }
    
    // Must be 6 elements
    static var victoryMessages: [String] = ["Perfection!", "Exquisite!", "Nice!", "Good job!", "Finally!", "That was close!"]
}
