//
//  BradleViewModel.swift
//  Bradle
//
//  Created by Brady Carden on 2/10/26.
//

import SwiftUI
import SwiftData

@MainActor
@Observable
class GameRunner {
    var modelContext: ModelContext?
    
    /// Hard mode variables
    var hints: [Hint] = []
    var hardModeEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "hardModeEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "hardModeEnabled") }
    }
    
    /// Attempt Variables
    var submittedAttempts: [SubmittedAttempt]
    var currentAttempt: CurrentAttempt
    var numEmptyRows: Int {
        if gameComplete {
            return 6 - submittedAttempts.count
        } else if submittedAttempts.count < 6 {
            return 6 - submittedAttempts.count - 1
        } else {
            return 0
        }
    }
    
    /// Keyboard Variables
    var keyboardManager: KeyboardManager
    var hideKeyboard: Bool = false
    var isKeyboardEnabled: Bool = true // used to disable input while flip animation is active
    
    var shouldShakeCurrentAttempt: Bool = false
    
    var targetWord: [Letter]?
    var gameComplete: Bool = false
    var gameWon: Bool = false
    
    /// Used for `GuessDistView` in `ResultsView`
    var recentGameGuessIndex: Int {
        gameWon ? submittedAttempts.count : -1
    }
    
    init() {
        self.keyboardManager = KeyboardManager()
        self.submittedAttempts = [SubmittedAttempt]()
        self.currentAttempt = CurrentAttempt()
        
    }
    
    func logout() {
        AccountStore.logout()
        
        self.keyboardManager = KeyboardManager()
        self.submittedAttempts = [SubmittedAttempt]()
        self.currentAttempt = CurrentAttempt()
        
        self.hints = []
        self.targetWord = nil
        AppState.shared.location = .start
    }
    
    public func getTargetWord() {
        // Assign target word to random word
        if let account = AccountStore.shared.account, Calendar.current.isDateInToday(account.lastWonGameDate) {
            let targetWordString = Constants.words[account.nextWordIndex]
            self.targetWord = Letter.formTargetWord(from: targetWordString)
            print("Target Word: \(targetWordString)")
        } else if let targetWordString = Constants.words.randomElement() {
            print("Target Word: \(targetWordString)")
            self.targetWord = Letter.formTargetWord(from: targetWordString)
        } else {
            fatalError("Could not get a target word.")
        }
    }
    
    // Performs action from keyboard button press
    public func handlePress(from key: KeyboardButton) {
        
        guard isKeyboardEnabled else { return }
        
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
        
        guard let targetWord else { return }
        
        guard isAttemptValid(attempt) else {
            shouldShakeCurrentAttempt.toggle()
            return
        }
        
        // MARK: Evaluate valid submission
        
        // Check if attempt is correct
        if attempt == targetWord {
            let submittedAttempt = SubmittedAttempt(
                letter: attempt,
                statuses: Array(repeating: .correct, count: 5),
                isTarget: true
            )
            submittedAttempts.append(submittedAttempt)
            
            gameComplete = true
            gameWon = true
            AccountStore.shared.account?.handleFinishedGame(success: true, submittedAttempts: submittedAttempts, hardModeEnabled: hardModeEnabled)
            try? modelContext?.save()
            
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 4_500_000_000)
                AppState.shared.fullScreenCover = .results(.victory(submittedAttempts.count))
            }
            
            setVictoryMessage()
            
            print("Game Complete.")
            return
        }
        
        // Evalute submitted attempt if valid but not target
        var statusArray: [SubmittedStatus] = Array(repeating: .notIncluded, count: 5)
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
                keyboardManager.buttonStatus[letter] = .notIncluded
            }
        }
        
        // MARK: - Submit Attemmpt
        
        isKeyboardEnabled = false // Disable keyboard while flip animation is running
        let submittedAttempt = SubmittedAttempt(letter: currentAttempt.letters, statuses: statusArray)
        submittedAttempts.append(submittedAttempt)
        updateHints(with: submittedAttempt)
        
        // Reenable keyboard when flip animation is done
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            isKeyboardEnabled = true
        }
        
        // MARK: - Advance to next turn
        
        // if player has more attempts left
        if submittedAttempts.count < 6 {
            currentAttempt = CurrentAttempt()
            
        // if out of attempts
        } else {
            gameComplete = true
            AccountStore.shared.account?.handleFinishedGame(success: false, submittedAttempts: submittedAttempts, hardModeEnabled: hardModeEnabled)
            try? modelContext?.save()
            
            Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                showAlert(withMessage: .word(targetWord.toString()), dismiss: false)
                
                try? await Task.sleep(nanoseconds: 2_500_000_000)
                AppState.shared.fullScreenCover = .results(.fail)
            }
        }
    }
    
    func isAttemptValid(_ attempt: [Letter]) -> Bool {
        // Ensure that the attempt is full
        if attempt.contains(.empty) {
            showAlert(withMessage: .notEnoughLetters)
            return false
        }
        
        // Check that word is a valid word
        if !Constants.words.contains(attempt.toString()) {
            showAlert(withMessage: .notInWordList)
            return false
        }
        
        // Check hard more conformance
        if hardModeEnabled, let failedHint = checkHintConformance(for: attempt) {
            showAlert(withMessage: .unsatisfiedHint(failedHint))
            return false
        }
        
        return true
    }
    
    // Sets alertMessage if game is won
    func setVictoryMessage() {
        Task {
            
            // Delay to allow flip animation to reveal status
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            showAlert(withMessage: .victoryMessages[submittedAttempts.count - 1], duration: 2_500_000_000)
        }
    }
    
    func showAlert(withMessage message: AlertMessage, dismiss: Bool = true, duration: UInt64 = 1_000_000_000) {
        AppState.shared.alertMessage = message
        
        if dismiss {
            Task {
                try? await Task.sleep(nanoseconds: duration)
                withAnimation(.easeOut(duration: 0.2)) {
                    AppState.shared.alertMessage = nil
                }
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
        guard hardModeEnabled else { return }
        
        for (index, (letter, status)) in submittedAttempt.letterStatuses.enumerated() {
           
           if status == .included, !hints.contains(where: {$0.letter == letter }) {
               hints.append(Hint(letter: letter, location: nil))
                
            } else if status == .correct, let hintIndex = hints.firstIndex(where: { $0.letter == letter } ) {
                hints[hintIndex].location = index
            }
        }
    }
    
    func textRepresentation() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        let today = formatter.string(from: Date.now)
        
        var result = "Bradle \(today)\n\n"
        for attempt in submittedAttempts {
            for status in attempt.statuses {
                result += status.emoji
            }
            result += "\n"
        }
        
        return result
    }
}
