//
//  Float.swift
//  Bradle
//
//  Created by Brady Carden on 3/4/26.
//

import SwiftUI

enum FloatAnimation: CaseIterable {
    case initial
    case peak
    case end
    
    var yOffset: CGFloat {
        switch self {
        case .initial: 0
        case .peak: -40
        case .end: 0
        }
    }
    
    var duration: CGFloat {
        switch self {
        case .initial: 0
        case .peak: 0.2
        case .end: 0.2
        }
    }
    
    static var phases: [FloatAnimation] {
        FloatAnimation.allCases
    }
}

extension View {
    
    /// View Modifier that runs float animation
    /// Performed on later SubmittedAttemptView is submission is the target word
    func floatAnimation(trigger: Bool, index: Int) -> some View  {
        phaseAnimator(FloatAnimation.phases, trigger: trigger) { content, phase in
            content.offset(y: phase.yOffset)
        } animation: { phase in
            .easeOut(duration: phase.duration).delay(phase == .peak ? (0.1 * CGFloat(index)) : 0)
        }
    }
}
