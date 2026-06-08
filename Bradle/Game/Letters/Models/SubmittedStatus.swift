//
//  SubmittedStatus.swift
//  Bradle
//
//  Created by Brady Carden on 3/4/26.
//

import SwiftUI

enum SubmittedStatus: CaseIterable {
    case notIncluded
    case included
    case correct
    
    var emoji: String {
        switch self {
        case .notIncluded:
            return "⬛"
        case .included:
            return "🟨"
        case .correct:
            return "🟩"
        }
    }
}
