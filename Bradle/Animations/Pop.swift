//
//  Pop.swift
//  Bradle
//
//  Created by Brady Carden on 3/4/26.
//

import SwiftUI

enum Pop: CaseIterable {
    case inital
    case popped
    case end
    
    var scale: CGFloat {
        switch self {
        case .inital: 1
        case .popped: 1.05
        case .end: 1
        }
    }
    
    var duration: CGFloat {
        switch self {
        case .inital: 0
        case .popped: 0
        case .end: 0.0125
        }
    }
    
    static var phases: [Pop] {
        Pop.allCases
    }
}

extension View {
    
    /// View Modifier that runs pop animation
    /// Performed on CurrentLetterView if letter receives a non-empty value
    func popAnimation(trigger: Bool) -> some View {
        phaseAnimator(Pop.phases, trigger: trigger) { content, phase in
            content
                .scaleEffect(phase.scale)
        } animation: { phase in
                .linear(duration: phase.duration)
        }
    }
}
