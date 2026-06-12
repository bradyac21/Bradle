//
//  Flip.swift
//  Bradle
//
//  Created by Brady Carden on 3/4/26.
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
    
    var duration: CGFloat {
        switch self {
            
        case .initial: 0
        case .halfway: Constants.letterFlipPhaseDuration
        case .end: Constants.letterFlipPhaseDuration
        }
    }
    
    static var phases: [FlipAnimation] {
        return FlipAnimation.allCases
    }
}
