//
//  KeyboardManager.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct KeyboardManager {
    var buttonStatus: [Letter: Status]
    
    init() {
        buttonStatus = [Letter: Status]()
        for letter in Letter.allCases {
            buttonStatus[letter] = .notTried
        }
    }
    
    func getButtonColor(for key: KeyboardButton) -> Color {
        if [.enter, .backspace].contains(key) {
            return Color(UIColor.lightGray)
        } else {
            if let letter = Letter(rawValue: key.rawValue) {
                return buttonStatus[letter]?.color ?? .red
            }
        }
        
        // bad
        return .red
    }
}
