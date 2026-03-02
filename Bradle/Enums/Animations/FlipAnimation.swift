//
//  FlipAnimation.swift
//  Bradle
//
//  Created by Brady Carden on 2/14/26.
//

import SwiftUI

enum FlipAnimation: CaseIterable {
    case initial
    case halfway
    case end
    
    var yScale: CGFloat {
        switch self {
        case .initial: 1
        case .halfway: 0
        case .end: 1
        }
    }
    
    /// Total animation time for Flip Animation
    static var totalDuration: CGFloat {
        return 2
    }
    
    static var phases: [FlipAnimation] {
        return FlipAnimation.allCases
    }
}
