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
    case attemptInProgress
    
    public var color: Color {
        switch self {
            
        case .notTried, .action:
            return BradleColors.lightGray
        case .defaultStatus:
            return BradleColors.dark
        case .notIncluded, .attemptInProgress:
            return BradleColors.darkGray
        case .included:
            return BradleColors.yellow
        case .correct:
            return BradleColors.green
        }
    }
    
    public var letterBackground: any View {
        switch self {
        case .correct, .included, .notIncluded:
            return RoundedRectangle(cornerRadius: 5)
                .fill(self.color)
                .aspectRatio(1.0, contentMode: .fit)
        case .attemptInProgress:
            return RoundedRectangle(cornerRadius: 5)
                .fill(.clear)
                .aspectRatio(1.0, contentMode: .fit)
                .border(BradleColors.lightGray, width: 2)
        default:
            return RoundedRectangle(cornerRadius: 5)
                .fill(.clear)
                .aspectRatio(1.0, contentMode: .fit)
                .border(BradleColors.lightModeEmptyBorder, width: 2)
        }
    }
}
