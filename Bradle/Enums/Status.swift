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
}
