//
//  BadgeColors.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

enum BadgeColors {
    static let mint = Color(red: 182, green: 206, blue: 175)
    static let gray = Color(red: 212, green: 214, blue: 220)
    static let background = Color(red: 42, green: 42, blue: 42)
}

enum BadgeSize {
    case small
    case large
    
    var constant: CGFloat {
        switch self {
        case .small: 1
        case .large: 3
        }
    }
}
