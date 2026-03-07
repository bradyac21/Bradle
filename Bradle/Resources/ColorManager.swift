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
            updateDarkModeColors()
        }
    }
    var highContrastEnabled: Bool = false {
        didSet {
            UserDefaults.standard.set(highContrastEnabled, forKey: "highContrastEnabled")
            updateHighContrastColors()
        }
    }

    var gameBackground: Color
    var defaultBackground: Color
    var primary: Color
    var secondary: Color
    
    var submittedStatusColors: [SubmittedStatus?: Color]
    var currentStatusBorderColors: [CurrentStatus: Color]
    
    init() {
        
        // Creating a varible for these to be used in the init
        let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        let highContrastEnabled = UserDefaults.standard.bool(forKey: "highContrastEnabled")
        
        self.darkModeEnabled = darkModeEnabled
        self.highContrastEnabled = highContrastEnabled
        
        if darkModeEnabled {
            self.gameBackground = BradleColors.darkModeBackground
            self.defaultBackground = BradleColors.dark
            
            self.primary = .white
            self.secondary = .black
        } else {
            self.gameBackground = BradleColors.lightModeBackground
            self.defaultBackground = BradleColors.light
            
            self.primary = .black
            self.secondary = .white
        }
        
        self.submittedStatusColors = [
            .correct: highContrastEnabled ? BradleColors.highContrastCorrect : BradleColors.green,
            .included: highContrastEnabled ? BradleColors.highContrastIncluded : BradleColors.yellow,
            .notIncluded: darkModeEnabled ? BradleColors.darkModeNotIncluded : BradleColors.lightModeNotIncluded,
            nil: darkModeEnabled ? BradleColors.darkModeKeyboardFrameColor : BradleColors.lightModeKeyboardFrameColor
        ]
        
        self.currentStatusBorderColors = [
            .empty: darkModeEnabled ? BradleColors.darkModeEmptyBorder : BradleColors.lightModeEmptyBorder,
            .filled: darkModeEnabled ? BradleColors.darkModeFilledBorder : BradleColors.lightModeFilledBorder
        ]
    }
    
    private func updateDarkModeColors() {
        if darkModeEnabled {
            self.gameBackground = BradleColors.darkModeBackground
            self.defaultBackground = BradleColors.dark
            
            self.primary = .white
            self.secondary = .black
        } else {
            self.gameBackground = BradleColors.lightModeBackground
            self.defaultBackground = BradleColors.light
            
            self.primary = .black
            self.secondary = .white
        }
        
        submittedStatusColors[.notIncluded] = darkModeEnabled ? BradleColors.darkModeNotIncluded : BradleColors.lightModeNotIncluded
        submittedStatusColors[nil] = darkModeEnabled ? BradleColors.darkModeKeyboardFrameColor : BradleColors.lightModeKeyboardFrameColor
        
        currentStatusBorderColors[.empty] = darkModeEnabled ? BradleColors.darkModeEmptyBorder : BradleColors.lightModeEmptyBorder
        currentStatusBorderColors[.filled] = darkModeEnabled ? BradleColors.darkModeFilledBorder : BradleColors.lightModeFilledBorder
    }
    
    private func updateHighContrastColors() {
        submittedStatusColors[.correct] = highContrastEnabled ? BradleColors.highContrastCorrect : BradleColors.green
        submittedStatusColors[.included] = highContrastEnabled ? BradleColors.highContrastIncluded : BradleColors.yellow
    }
}

extension Dictionary where Key == CurrentStatus, Value == Color {
    subscript(safeKey status: CurrentStatus) -> Color {
        get {
            self[status] ?? .clear
        }

    }
}

extension Dictionary where Key == SubmittedStatus?, Value == Color  {
    subscript(safeKey status: SubmittedStatus?) -> Color {
        get {
            self[status] ?? .clear
        }

    }
}

extension ColorManager {
    // Used for the font color of the keyboard, probably should be moved into something else
    subscript(safeKey key: SubmittedStatus?) -> Color {
        get {
            if key == nil {
                self.darkModeEnabled ? .white : .black
            } else {
                .white
            }
        }
    }
}
