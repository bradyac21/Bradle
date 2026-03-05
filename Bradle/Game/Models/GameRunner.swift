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
            
            /// Need to wait for animations before showing victory screen
            if fullScreenCover == .victory {
                //DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.showFullScreenCover = true
                //}
                
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
            self.showAlert = true
        }
    }
    
    @Published var showAlert: Bool = false {
        didSet {
            // Stop showing alert after 2 seconds
            if showAlert {
                Task {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    withAnimation(.easeOut(duration: 0.2)) {
                        showAlert = false
                    }
                }
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
            alertMessage = AlertMessage.notEnoughLetters.message
            shouldShake.toggle()
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
        
        // Check if attempt is correct
        if attempt == targetWord {
            let submittedAttempt = SubmittedAttempt(letter: attempt, statuses: Array(repeating: .correct, count: 5), isTarget: true)
            submittedAttempts.append(submittedAttempt)
            
            targetWordFound = true
            
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 4_500_000_000)
                fullScreenCover = .victory
            }
            
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
        
        // MARK: - Advance to next turn
        
        // if player has more attempts left
        if currentAttemptIndex < 6 {
            currentAttemptIndex += 1
            numEmptyRows -= 1

            // Disable keyboard while flip animation is running
            disableKeyboard()

            // create submitted attempt attempt and
            let submittedAttempt = SubmittedAttempt(letter: currentAttempt.letters, statuses: statusArray)
            submittedAttempts.append(submittedAttempt)
            
            // set current attempt to empty
            currentAttempt = CurrentAttempt()
            
            // Reenable keyboard when flip animation is done
            Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                enableKeyboard()
            }
            
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
    
    func enableKeyboard() {
        self.disableKeyboardInput = false
    }
    
    func disableKeyboard() {
        self.disableKeyboardInput = true
    }
}
