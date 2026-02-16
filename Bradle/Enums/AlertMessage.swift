//
//  AlertMessage.swift
//  Bradle
//
//  Created by Brady Carden on 2/10/26.
//

enum AlertMessage {
    case notInWordList
    case notEnoughLetters
    case victoryIn1
    case victoryIn2
    case victoryIn3
    case victoryIn4
    case victoryIn5
    case victoryIn6
    case fail
    
    var message: String {
        switch self {
            
        case .notInWordList:
            "Not in Word List"
        case .notEnoughLetters:
            "Not Enough Letters"
        case .victoryIn1:
            "Perfection!"
        case .victoryIn2:
            "Exquisite!"
        case .victoryIn3:
            "Nice!"
        case .victoryIn4:
            "Good job!"
        case .victoryIn5:
            "Finally!"
        case .victoryIn6:
            "That was close!"
        case .fail:
            "Maybe next time"
        }
    }
}
