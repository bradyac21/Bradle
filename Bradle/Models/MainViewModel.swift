//
//  bradleViewModel.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var submittedAttempts: [SubmittedAttempt]
    @Published var currentAttempt: CurrentAttempt
    @Published var gameComplete: Bool
    
    @Published var currentAttemptIndex: Int = 0
    @Published var shouldShake: Bool = false
    @Published var alertMessage: String = " " {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.alertMessage = " "
            }
        }
    }
    
    var keyboardManager: KeyboardManager
    let targetWord: [Letter]
    let words: [String]
    
    init() {
        self.keyboardManager = KeyboardManager()
        self.submittedAttempts = [SubmittedAttempt]()
        self.currentAttempt = CurrentAttempt()
        self.gameComplete = false
        
        // Read words file
        guard let file = Bundle.main.url(forResource: "words", withExtension: "json") else {
            fatalError("Could not find words file.")
        }
        
        do {
            let data = try Data(contentsOf: file)
            try self.words = JSONDecoder().decode([String].self, from: data)
        } catch {
            fatalError("An error occured. Could not decode words file.")
        }
        
        if let targetWord = words.randomElement() {
            print("Target Word: \(targetWord)")
            self.targetWord = Letter.formTargetWord(from: targetWord)
        } else {
            fatalError("Could not get a target word.")
        }
    }
    
    public func handlePress(from key: KeyboardButton) {
        if key == .enter {
            handleSubmit(for: currentAttempt.attempt)
        } else if key == .backspace {
            currentAttempt.backspace()
        } else {
            currentAttempt.addLetter(key.letter)
        }
    }
    
    public func handleSubmit(for attempt: [Letter]) {
        
        // Ensure that the attempt is full
        if targetWord.contains(.empty) { return }
        
        // Check that word is a valid word
        if !words.contains(attempt.toString()) {
            // trigger shake animation
            shouldShake.toggle()
            alertMessage = AlertMessage.notInWordList.message
            return
        }
        
        // Check if attempt is correct
        if attempt == targetWord {
            let submittedAttempt = SubmittedAttempt(attempt: attempt, statuses: Array(repeating: .correct, count: 5))
            submittedAttempts.append(submittedAttempt)
            alertMessage = getVictoryMessage(attempts: submittedAttempts.count)
            gameComplete = true
            print("Game Complete.")
            return
        }
        
        var statusArray = Array(repeating: Status.notTried, count: 5)
        for (index, letter) in attempt.enumerated() {
            if targetWord.contains(letter) {
                if targetWord[index] == letter {
                    statusArray[index] = .correct
                    keyboardManager.buttonStatus[letter] = .correct
                } else {
                    statusArray[index] = .included
                    keyboardManager.buttonStatus[letter] = .included
                }
                
            } else {
                statusArray[index] = .notIncluded
                keyboardManager.buttonStatus[letter] = .notIncluded
            }
        }
        
        let submittedAttempt = SubmittedAttempt(attempt: currentAttempt.attempt, statuses: statusArray)
        currentAttempt = CurrentAttempt()
        submittedAttempts.append(submittedAttempt)
        
        if currentAttemptIndex < 6 {
            currentAttemptIndex += 1
        } else {
            alertMessage = AlertMessage.fail.message
            gameComplete = true
        }
    }
    
    static func getWords() -> [String] {
        guard let file = Bundle.main.url(forResource: "words", withExtension: "json") else {
            fatalError("Could not find words file.")
        }
        
        do {
            let data = try Data(contentsOf: file)
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            fatalError("An error occured. Could not decode words file.")
        }
    }
    
    func getVictoryMessage(attempts: Int) -> String {
        if attempts == 1 {
            return AlertMessage.victoryIn1.message
        }
        
        if attempts == 2 {
            return AlertMessage.victoryIn2.message
        }
        
        if attempts == 3 {
            return AlertMessage.victoryIn3.message
        }
        
        if attempts == 4 {
            return AlertMessage.victoryIn4.message
        }
        
        if attempts == 5 {
            return AlertMessage.victoryIn5.message
        }
        
        if attempts == 6 {
            return AlertMessage.victoryIn6.message
        }
        
        else {
            return "Oops.."
        }
    }
}
