//
//  LetterStatus.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//
import SwiftUI

enum Status {
    case notTried
    case notIncluded
    case included
    case correct
    case action
    case defaultStatus
    case typing
    
    public var color: Color {
        switch self {
            
        case .notTried, .action:
            return Color(UIColor.lightGray)
        case .defaultStatus:
            return darkBackground
        case .notIncluded, .typing:
            return Color(UIColor.darkGray)
        case .included:
            return .yellow
        case .correct:
            return .green
        }
    }
    
    public var background: any View {
        switch self {
        case .correct, .included, .notIncluded:
            return RoundedRectangle(cornerRadius: 5)
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundStyle(self.color)
        case .typing:
            return RoundedRectangle(cornerRadius: 5)
                .aspectRatio(1.0, contentMode: .fit)
                .border(Color(UIColor.lightGray))
        default:
            return RoundedRectangle(cornerRadius: 5)
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundStyle(darkBackground)
                .border(Color(UIColor.darkGray))
        }
    }
}
