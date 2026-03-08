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
    var hints: [Hint] = []
    
    @Published var location: AppLocation = .start
    @Published var fullScreenCover: FullScreenCover = .empty {
        didSet {
            
            /// Need to wait for animations before showing victory screen
            if fullScreenCover == .victory {
                self.showFullScreenCover = true
                
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
    
    var numEmptyRows: Int {
        if gameComplete {
            return 6 - submittedAttempts.count
        } else if submittedAttempts.count < 6 {
            return 6 - submittedAttempts.count - 1
        } else {
            return 0
        }
    }
    @Published var submittedAttempts: [SubmittedAttempt]
    @Published var currentAttempt: CurrentAttempt
    
    @Published var gameComplete: Bool = false
    @Published var hideKeyboard: Bool = false
    
    @Published var currentAttemptIndex: Int = 0
    @Published var shouldShake: Bool = false
    @Published var alertMessage: AlertMessage = .empty
    
    @Published var shouldShowAlert: Bool = false
    
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
            handleSubmit(for: currentAttempt.letters)
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
        if attempt.contains(.empty) {
            shouldShake.toggle()
            showAlert(withMessage: .notEnoughLetters)
            
            return
        }
        
        // Check that word is a valid word
        if !words.contains(attempt.toString()) {
            shouldShake.toggle()
            showAlert(withMessage: .notInWordList)
            
            return
        }
        
        // Check hard more conformance
        if hardModeEnabled {
            // Evaluate
            if let failedHint = checkHintConformance(for: attempt) {
                showUnsatisfiedHintAlert(for: failedHint)
                shouldShake.toggle()
                return
            }
        }
        
        // MARK: Evaluate valid submission
        
        // Check if attempt is correct
        if attempt == targetWord {
            let submittedAttempt = SubmittedAttempt(letter: attempt, statuses: Array(repeating: .correct, count: 5), isTarget: true)
            submittedAttempts.append(submittedAttempt)
            
            gameComplete = true
            
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 4_500_000_000)
                fullScreenCover = .victory
            }
            
            setVictoryMessage()
            
            print("Game Complete.")
            return
        }
        
        // Evalute submitted attempt if valid but not target
        var statusArray: [SubmittedStatus] = Array(repeating: .notIncluded, count: 5)
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
        
        // MARK: - Submit Attemmpt
        
        // Disable keyboard while flip animation is running
        disableKeyboard()
        
        // create submitted attempt
        let submittedAttempt = SubmittedAttempt(letter: currentAttempt.letters, statuses: statusArray)
        submittedAttempts.append(submittedAttempt)
        
        // update hints
        updateHints(with: submittedAttempt)
        
        // Reenable keyboard when flip animation is done
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            enableKeyboard()
        }
        
        // MARK: - Advance to next turn
        
        // if player has more attempts left
        if submittedAttempts.count < 6 {
            // set current attempt to empty
            currentAttempt = CurrentAttempt()
            
        // if out of attempts
        } else {
            gameComplete = true
            
            Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                showAlert(withMessage: .word(targetWord.toString()), dismiss: false)
                
                try? await Task.sleep(nanoseconds: 2_500_000_000)
                fullScreenCover = .victory
            }
        }
    }
    
    // Sets alertMessage if game is won
    func setVictoryMessage() {
        let attempts = submittedAttempts.count
        Task {
            
            // Delay to allow flip animation to reveal status
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            showAlert(withMessage: .victoryMessages[attempts - 1], duration: 2_500_000_000)
        }
    }
    
    func enableKeyboard() {
        self.disableKeyboardInput = false
    }
    
    func disableKeyboard() {
        self.disableKeyboardInput = true
    }
    
    func showAlert(withMessage message: AlertMessage, dismiss: Bool = true, duration: UInt64 = 1_000_000_000) {
        alertMessage = message
        shouldShowAlert = true
        
        if dismiss {
            Task {
                try? await Task.sleep(nanoseconds: duration)
                withAnimation(.easeOut(duration: 0.2)) {
                    shouldShowAlert = false
                    alertMessage = .empty
                }
            }
        }
    }
    
    func showUnsatisfiedHintAlert(for hint: Hint) {
        alertMessage = .unsatisfiedHint(hint)
        shouldShowAlert = true
        
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            withAnimation(.easeOut(duration: 0.2)) {
                shouldShowAlert = false
                alertMessage = .empty
            }
        }
    }
    
    func checkHintConformance(for attempt: [Letter]) -> Hint? {
        
        for hint in hints {
            
            // if the hint has a location, ensure hint letter is in correct location in attempt
            if let location = hint.location, attempt.firstIndex(of: hint.letter) != location {
                return hint
                
            // if the hint does not have location, ensure the word contains the hint letter
            } else if !attempt.contains(hint.letter) {
                return hint
            }
        }
        
        return nil
    }
    
    func updateHints(with submittedAttempt: SubmittedAttempt) {
        for (index, (letter, status)) in submittedAttempt.letterStatuses.enumerated() {
            
            // skip if not included
            // Uneccessary but technically a performance bonus
            if status == .notIncluded {
                continue
                
                // If letter is included in wrong spot
            } else if status == .included {
                
                // If there is not a hint for this letter already
                if !hints.contains(where: {$0.letter == letter }) {
                    
                    // Add hint. nil location represents any
                    hints.append(Hint(letter: letter, location: nil))
                }
                
                // If letter is in the correct spot
            } else if status == .correct {
                
                // if there is a hint for this letter with any location
                hints.removeAll(where: { $0.letter == letter && $0.location == nil })
                
                // Add a hint with a location
                hints.append(Hint(letter: letter, location: index))
            }
        }
        
        print("Updated Hints: \n\(hints)")
    }
}
