//
//  BradleViewModel.swift
//  Bradle
//
//  Created by Brady Carden on 2/10/26.
//

import SwiftUI
import Combine
import UserNotifications

class BradleViewModel: ObservableObject {
    @Published var location: AppLocation = .start
    @Published var fullScreenCover: FullScreenCover = .empty {
        didSet {
            if fullScreenCover == .victory {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.showFullScreenCover = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.hideKeyboard = true
                }
            } else if fullScreenCover != .empty {
                showFullScreenCover = true
            }
        }
    }
    @Published var showFullScreenCover: Bool = false {
        didSet {
            if !showFullScreenCover {
                fullScreenCover = .empty
            }
        }
    }
    
    @Published var sheet: BradleSheet = .empty {
        didSet {
            if sheet != .empty {
                showSheet = true
            }
        }
    }
    @Published var showSheet: Bool = false {
        didSet {
            if !showSheet {
                sheet = .empty
            }
        }
    }
    
    @Published var numEmptyRows: Int = 5
    @Published var submittedAttempts: [SubmittedAttempt]
    @Published var currentAttempt: CurrentAttempt
    
    
    @Published var gameComplete: Bool = false
    @Published var targetWordFound: Bool = false
    @Published var hideKeyboard: Bool = false
    
    @Published var currentAttemptIndex: Int = 0
    @Published var shouldShake: Bool = false
    @Published var alertMessage: String = " " {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.alertMessage = " "
            }
        }
    }
    
    // Is true while flip animation is running
    var pauseSubmit: Bool = false
    
    var keyboardManager: KeyboardManager
    let targetWord: [Letter]
    let words: [String]
    
    init() {
        self.keyboardManager = KeyboardManager()
        self.submittedAttempts = [SubmittedAttempt]()
        self.currentAttempt = CurrentAttempt()

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
        if key == .enter && !pauseSubmit {
            handleSubmit(for: currentAttempt.attempt)
        } else if key == .backspace {
            currentAttempt.backspace()
        } else {
            currentAttempt.addLetter(key.letter)
        }
    }
    
    public func handleSubmit(for attempt: [Letter]) {
        
        // Ensure that the attempt is full
        if targetWord.contains(.empty) {
            alertMessage = AlertMessage.notEnoughLetters.message
            return
        }
        
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
            targetWordFound = true
            self.fullScreenCover = .victory
            
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
                
        if currentAttemptIndex < 6 {
            currentAttemptIndex += 1
            numEmptyRows -= 1
            
            let submittedAttempt = SubmittedAttempt(attempt: currentAttempt.attempt, statuses: statusArray)
            submittedAttempts.append(submittedAttempt)
            currentAttempt = CurrentAttempt()
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
    
    func setVictoryMessage() {
        let attempts = submittedAttempts.count
        if attempts == 1 {
            alertMessage = AlertMessage.victoryIn1.message
        }
        
        else if attempts == 2 {
            alertMessage = AlertMessage.victoryIn2.message
        }
        
        else if attempts == 3 {
            alertMessage = AlertMessage.victoryIn3.message
        }
        
        else if attempts == 4 {
            alertMessage = AlertMessage.victoryIn4.message
        }
        
        else if attempts == 5 {
            alertMessage = AlertMessage.victoryIn5.message
        }
        
        else if attempts == 6 {
            alertMessage = AlertMessage.victoryIn6.message
        }
        
        else {
            alertMessage = "Oops.."
        }
    }
}
