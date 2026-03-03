//
//  ColorManager.swift
//  Bradle
//
//  Created by Brady Carden on 3/2/26.
//

import SwiftUI

@Observable
class ColorManager {
    var darkModeEnabled: Bool = true {
        didSet {
            UserDefaults.standard.set(darkModeEnabled, forKey: "darkModeEnabled")
            updateDarkModeColors(using: darkModeEnabled)
        }
    }
    var highContrastEnabled: Bool = false {
        didSet {
            UserDefaults.standard.set(highContrastEnabled, forKey: "highContrastEnabled")
            updateHighContrastColors(using: highContrastEnabled)
        }
    }
    
    var emptyBorder: Color
    var filledBorder: Color
    
    var emptyBackground: Color = .clear
    var filledBackground: Color = .clear
    var correctBackground: Color
    var includedBackground: Color
    var notIncludedBackground: Color = .clear
    
    var gameBackground: Color
    var defaultBackground: Color
    
    var keyboardBackground: Color
    
    var textColor: Color
    
    init() {
        
        // Creating a varible for these to be used in the init
        let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        let highContrastEnabled = UserDefaults.standard.bool(forKey: "highContrastEnabled")
        
        self.darkModeEnabled = darkModeEnabled
        self.highContrastEnabled = highContrastEnabled
        
        if darkModeEnabled {
            self.emptyBorder = BradleColors.darkModeEmptyBorder
            self.filledBorder = BradleColors.darkModeFilledBorder
            self.notIncludedBackground = BradleColors.darkModeNotIncluded
            
            self.gameBackground = BradleColors.darkModeBackground
            self.defaultBackground = BradleColors.dark
            
            self.keyboardBackground = BradleColors.darkModeKeyboardFrameColor
            self.textColor = .white
        } else {
            self.emptyBorder = BradleColors.lightModeEmptyBorder
            self.filledBorder = BradleColors.lightModeFilledBorder
            self.notIncludedBackground = BradleColors.lightModeNotIncluded
            
            self.gameBackground = BradleColors.lightModeBackground
            self.defaultBackground = BradleColors.light
            
            self.keyboardBackground = BradleColors.lightModeKeyboardFrameColor
            self.textColor = .black
        }
        
        if highContrastEnabled {
            self.correctBackground = BradleColors.highContrastCorrect
            self.includedBackground = BradleColors.highContrastIncluded
            
        } else {
            self.correctBackground = BradleColors.green
            self.includedBackground = BradleColors.yellow
        }
    }
    
    private func updateDarkModeColors(using darkModeEnabled: Bool) {
        if darkModeEnabled {
            self.emptyBorder = BradleColors.darkModeEmptyBorder
            self.filledBorder = BradleColors.darkModeFilledBorder
            self.notIncludedBackground = BradleColors.darkModeNotIncluded
            
            self.gameBackground = BradleColors.darkModeBackground
            self.defaultBackground = BradleColors.dark
            
            self.keyboardBackground = BradleColors.darkModeKeyboardFrameColor
            self.textColor = .white
        } else {
            self.emptyBorder = BradleColors.lightModeEmptyBorder
            self.filledBorder = BradleColors.lightModeFilledBorder
            self.notIncludedBackground = BradleColors.lightModeNotIncluded
            
            self.gameBackground = BradleColors.lightModeBackground
            self.defaultBackground = BradleColors.light
            
            self.keyboardBackground = BradleColors.lightModeKeyboardFrameColor
            self.textColor = .black
        }
        
    }
    
    private func updateHighContrastColors(using highContrastEnabled: Bool) {
        if highContrastEnabled {
            self.correctBackground = BradleColors.highContrastCorrect
            
            self.includedBackground = BradleColors.highContrastIncluded
        } else {
            self.correctBackground = BradleColors.green
            
            self.includedBackground = BradleColors.yellow
        }
    }
    
    func borderColor(for status: Status) -> Color {
        .red
//        switch status {
//            
//        case .notTried:
//            keyboardBackground
//        case .notIncluded:
//            notIncludedBorder
//        case .included:
//            includedBorder
//        case .correct:
//            correctBorder
//        case .action:
//            keyboardBackground
//        case .empty:
//            emptyBorder
//        case .attemptInProgress:
//            filledBorder
//        }
    }
    
    func getBackgroundColor(for status: Status) -> Color {
        switch status {
            
        case .notTried:
            keyboardBackground
        case .notIncluded:
            notIncludedBackground
        case .included:
            includedBackground
        case .correct:
            correctBackground
        case .action:
            keyboardBackground
        case .empty:
            emptyBackground
        case .attemptInProgress:
            filledBackground
        }
    }
    
    func getBackgroundColor(for status: SubmittedAttemptLetterStatus) -> Color {
        switch status {
        case .unsubmitted:
                .red
        case .notIncluded:
            notIncludedBackground
        case .included:
            includedBackground
        case .correct:
            correctBackground
        }
    }

}
