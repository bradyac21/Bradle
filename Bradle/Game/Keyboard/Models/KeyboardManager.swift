//
//  KeyboardManager.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct KeyboardManager {
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    var buttonStatus: [Letter: SubmittedStatus] = [:]
    
    init() {
//        buttonStatus = [Letter: SubmittedStatus?]()
//        for letter in Letter.allCases {
//            buttonStatus[letter] = nil
//        }
    }
    
    func getButtonStatus(for key: KeyboardButton) -> SubmittedStatus? {
        if key == .enter || key == .backspace {
            return nil
        } else {
            if let letter = Letter(rawValue: key.rawValue), let status = buttonStatus[letter] {
                return status
            }
        }
        
        // Bad
        return nil
    }
}

extension Dictionary where Key == Letter, Value == SubmittedStatus {
    subscript(safeKey key: KeyboardButton) -> SubmittedStatus? {
        get {
            self[key.letter]
        }
        set {
            self[key.letter] = newValue
        }
    }
}
