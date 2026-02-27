//
//  KeyboardManager.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct KeyboardManager {
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    var buttonStatus: [Letter: Status]
    
    init() {
        buttonStatus = [Letter: Status]()
        for letter in Letter.allCases {
            buttonStatus[letter] = .correct
        }
    }
    
    func getButtonColor(for key: KeyboardButton) -> Color {
        if [.enter, .backspace].contains(key) {
            return BradleColors.defaultKeyboardColor
        } else {
            if let letter = Letter(rawValue: key.rawValue) {
                if darkModeEnabled {
                    return buttonStatus[letter]?.darkModeColor ?? .red
                } else {
                    return buttonStatus[letter]?.lightModeColor ?? .red
                }
            }
        }
        
        // bad
        return .red
    }
}
