//
//  Shake.swift
//  Bradle
//
//  Created by Brady Carden on 3/4/26.
//

import SwiftUI

enum Shake: CaseIterable {
    case initial
    case leftOne
    case rightOne
    case leftTwo
    case rightTwo
    case leftThree
    case rightThree
    case leftFour
    case rightFour
    case done
    
    var xOffset: CGFloat {
        switch self {
            
        case .initial: 0
        case .leftOne: -2
        case .rightOne: 4
        case .leftTwo: -4
        case .rightTwo: 4
        case .leftThree: -4
        case .rightThree: 4
        case .leftFour: -2
        case .rightFour: 2
        case .done: 0
        }
    }
    
    static var phases: [Shake] {
        return Shake.allCases
    }
}

extension View {
    
    /// View Modifier that runs shake animation
    /// Performed on CurrentAttemptView if submission is invalid
    func shakeAnimation(trigger: Bool) -> some View {
        phaseAnimator(Shake.phases, trigger: trigger) { content, phase in
            content
                .offset(x: phase.xOffset)
        } animation: { _ in
            .spring(duration: 0.01)
        }
    }
}
