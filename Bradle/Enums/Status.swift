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
    case empty
    case attemptInProgress
    
//    public var color: Color {
//        switch self {
//            
//        case .notTried, .action:
//            return BradleColors.defaultKeyboardColor
//        case .empty, .attemptInProgress:
//            return .clear
//        case .notIncluded:
//            return BradleColors.darkGray
//        case .included:
//            return BradleColors.yellow
//        case .correct:
//            return BradleColors.green
//        }
//    }
    
    public var darkModeColor: Color {
        switch self {
            
        case .notTried:
            BradleColors.darkModeKeyboardFrameColor
        case .notIncluded:
            BradleColors.darkModeNotIncluded
        case .included:
            BradleColors.yellow
        case .correct:
            BradleColors.green
        case .action:
            BradleColors.darkModeKeyboardFrameColor
        case .empty:
                .clear
        case .attemptInProgress:
                .clear
        }
    }
    
    public var lightModeColor: Color {
        switch self {
            
        case .notTried:
            BradleColors.lightModeKeyboardFrameColor
        case .notIncluded:
            BradleColors.lightModeNotIncluded
        case .included:
            BradleColors.yellow
        case .correct:
            BradleColors.green
        case .action:
            BradleColors.lightModeKeyboardFrameColor
        case .empty:
                .clear
        case .attemptInProgress:
                .clear
        }
    }
    
    public var lightModeBorderColor: Color {
        switch self {
            
        case .notIncluded:
            BradleColors.lightModeNotIncluded
        case .included:
            BradleColors.green
        case .correct:
                BradleColors.green
        case .empty:
            BradleColors.lightModeEmptyBorder
        case .attemptInProgress:
            BradleColors.lightModeFilledBorder
            
        // .notTried and .action should not use border
        default:
            .red
        }
    }
    
    public var darkModeBorderColor: Color {
        switch self {
            
        case .notIncluded:
            BradleColors.darkModeNotIncluded
        case .included:
            BradleColors.yellow
        case .correct:
                BradleColors.green
        case .empty:
            BradleColors.darkModeEmptyBorder
        case .attemptInProgress:
            BradleColors.darkModeFilledBorder
            
        // .notTried and .action should not use border
        default:
            .red
        }
    }
    
//    public var letterBackground: any View {
//        switch self {
//        case .correct, .included, .notIncluded:
//            return RoundedRectangle(cornerRadius: 5)
//                .fill(self.color)
//                .aspectRatio(1.0, contentMode: .fit)
//        case .attemptInProgress:
//            return RoundedRectangle(cornerRadius: 5)
//                .fill(.clear)
//                .aspectRatio(1.0, contentMode: .fit)
//                .border(BradleColors.lightGray, width: 2)
//        default:
//            return RoundedRectangle(cornerRadius: 5)
//                .fill(.clear)
//                .aspectRatio(1.0, contentMode: .fit)
//                .border(BradleColors.lightModeEmptyBorder, width: 2)
//        }
//    }
    
}
