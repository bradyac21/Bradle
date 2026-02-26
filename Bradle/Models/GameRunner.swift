//
//  BradleViewModel.swift
//  Bradle
//
//  Created by Brady Carden on 2/10/26.
//

import SwiftUI
import Combine
import UserNotifications

class GameRunner: ObservableObject {
    @AppStorage("hardMode") var hardModeEnabled: Bool = false
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
    var disableKeyboardInput: Bool = false
    
    var keyboardManager: KeyboardManager
    let targetWord: [Letter]
    let words: [String]
    
    init() {
        self.keyboardManager = KeyboardManager()
        self.submittedAttempts = [SubmittedAttempt]()
        self.currentAttempt = CurrentAttempt()

        // Find words file
        guard let file = Bundle.main.url(forResource: "words", withExtension: "json") else {
            fatalError("Could not find words file.")
        }
        
        // Read words from file, assign to words
        do {
            let data = try Data(contentsOf: file)
            try self.words = JSONDecoder().decode([String].self, from: data)
        } catch {
            fatalError("An error occured. Could not decode words file.")
        }
        
        // Assign target word to random word
        if let targetWord = words.randomElement() {
            print("Target Word: \(targetWord)")
            self.targetWord = Letter.formTargetWord(from: targetWord)
        } else {
            fatalError("Could not get a target word.")
        }
    }
    
    // Performs action from keyboard button press
    public func handlePress(from key: KeyboardButton) {
        
        // Do not allow input if in an animation
        if disableKeyboardInput {
            return
        }
        
        if key == .enter {
            handleSubmit(for: currentAttempt.attempt)
        } else if key == .backspace {
            currentAttempt.backspace()
        } else {
            currentAttempt.addLetter(key.letter)
        }
    }
    
    // Process submitted word when "ENTER" keyboard button is tapped
    public func handleSubmit(for attempt: [Letter]) {
        
        // MARK: Validate submitted input
        
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
        
        // TODO: Add check for hard mode conformance
        if hardModeEnabled {
            // Evaluate
        }
        
        // MARK: Evaluate valid submission
        self.disableKeyboardInput = true
        
        // Check if attempt is correct
        if attempt == targetWord {
            let submittedAttempt = SubmittedAttempt(attempt: attempt, statuses: Array(repeating: .correct, count: 5))
            submittedAttempts.append(submittedAttempt)
            
            targetWordFound = true
            fullScreenCover = .victory
            
            print("Game Complete.")
            return
        }
        
        // Evalute submitted attempt if valid but not target
        var statusArray = Array(repeating: Status.notIncluded, count: 5)
        for (index, letter) in attempt.enumerated() {
            if targetWord.contains(letter) {
                
                // if letter is in correct location
                if targetWord[index] == letter {
                    statusArray[index] = .correct
                    keyboardManager.buttonStatus[letter] = .correct
                    
                // if word is included but in wrong spot
                } else {
                    statusArray[index] = .included
                    keyboardManager.buttonStatus[letter] = .included
                }
            
                // if letter is not included
            } else {
                keyboardManager.buttonStatus[letter] = .notIncluded
            }
        }
        
        //
        
        // MARK: - Advance to next turn
        
        // if player has more attempts left
        if currentAttemptIndex < 6 {
            currentAttemptIndex += 1
            numEmptyRows -= 1
            
            // create submitted attempt attempt and
            let submittedAttempt = SubmittedAttempt(attempt: currentAttempt.attempt, statuses: statusArray)
            submittedAttempts.append(submittedAttempt)
            
            // set current attempt to empty
            currentAttempt = CurrentAttempt()
            
        // if out of attempts
        } else {
            alertMessage = AlertMessage.fail.message
            gameComplete = true
        }
    }
    
    // Sets alertMessage if game is won
    func setVictoryMessage() {
        let attempts = submittedAttempts.count
        alertMessage = AlertMessage.victoryMessages[attempts - 1]
    }
}
