//
//  GameRunner2.swift
//  Bradle
//
//  Created by Brady Carden on 3/3/26.
//

import SwiftUI
import Combine

class GameRunner2: ObservableObject {
    @AppStorage("hardMode") var hardModeEnabled: Bool = false
    @Published var location: AppLocation = .start
    @Published var fullScreenCover: FullScreenCover = .empty {
        didSet {
            
            /// Need to wait for animations before showing victory screen
            if fullScreenCover == .victory {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.showFullScreenCover = true
                }
                
            // When fullScreenCover is assigned, trigger showing the sheet
            } else if fullScreenCover != .empty {
                showFullScreenCover = true
            }
        }
    }
    
    /// Whether or not the full screen cover should be shown
    @Published var showFullScreenCover: Bool = false {
        didSet {
            
            // Clear full screen cover if dismissed
            if !showFullScreenCover {
                fullScreenCover = .empty
            }
        }
    }
    
    /// Stores the sheet to be shown
    @Published var sheet: BradleSheet = .empty {
        didSet {
            
            // trigger showing sheet once sheet has a value
            if sheet != .empty {
                showSheet = true
            }
        }
    }
    
    /// Whether or not the sheet should be shown
    @Published var showSheet: Bool = false {
        didSet {
            
            // Clear sheet if dismissed
            if !showSheet {
                sheet = .empty
            }
        }
    }
    
    @Published var attempts: [AttemptRowModel]
    @Published var currentAttemptIndex: Int = 0 {
        didSet {
            self.attempts[currentAttemptIndex].isCurrent = true
        }
    }
    
    @Published var gameComplete: Bool = false
    @Published var targetWordFound: Bool = false
    @Published var hideKeyboard: Bool = false
    
//    @Published var shouldShake: Bool = false {
//        didSet {
//            attempt[currentAttemptIndex]
//        }
//    }
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
        self.attempts = [AttemptRowModel(), AttemptRowModel(), AttemptRowModel(), AttemptRowModel(), AttemptRowModel()]
        self.currentAttemptIndex = 0

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
        
        for attempt in attempts {
            print(attempt.attempt)
        }
        
        var attempt = attempts[currentAttemptIndex]
        
        if key == .enter {
            handleSubmit()
        } else if key == .backspace {
            attempt.attempt.backspace()
        } else {
            attempt.attempt.addLetter(key.letter)
        }
        
        print(attempt.attempt.attempt)
    }
    
    // Process submitted word when "ENTER" keyboard button is tapped
    public func handleSubmit() {
        
        var attempt = attempts[currentAttemptIndex]
        
        // MARK: Validate submitted input
        
        // Ensure that the attempt is full
        if targetWord.contains(.empty) {
            alertMessage = AlertMessage.notEnoughLetters.message
            return
        }
        
        // Check that word is a valid word
        if !words.contains(attempt.attempt.attempt.toString()) {
            // trigger shake animation
            //shouldShake.toggle()
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
        if attempt.attempt.attempt == targetWord {

            attempt.isCorrect = true
            attempt.isCurrent = false
            attempt.statuses = Array(repeating: .correct, count: 5)
            
            targetWordFound = true
            fullScreenCover = .victory
            
            print("Game Complete.")
            return
        }
        
        // Evalute submitted attempt if valid but not target
        var statusArray = Array(repeating: SubmittedAttemptLetterStatus.notIncluded, count: 5)
        for (index, letter) in attempt.attempt.attempt.enumerated() {
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
        
        
        // MARK: - Advance to next turn
        
        // if player has more attempts left
        if currentAttemptIndex < 6 {
                        
            attempt.isCurrent = false
            attempt.isSubmitted = true
            attempt.statuses = statusArray
            
            currentAttemptIndex += 1
            
            attempts[currentAttemptIndex].isCurrent = true

            
        // if out of attempts
        } else {
            alertMessage = AlertMessage.fail.message
            gameComplete = true
        }
    }
    
    // Sets alertMessage if game is won
    func setVictoryMessage() {
        let attempts = currentAttemptIndex
        alertMessage = AlertMessage.victoryMessages[attempts]
    }
    
    func enableKeyboard() {
        self.disableKeyboardInput = false
    }
    
    func disableKeyboard() {
        self.disableKeyboardInput = true
    }
}
