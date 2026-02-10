//
//  CurrentAttempt.swift
//  Wordle
//
//  Created by Brady Carden on 1/25/26.
//

import SwiftUI

struct AttemptView: View {
    let attemptCase: AttemptCase
    @EnvironmentObject var mainViewModel: MainViewModel
    
    public var body: some View {
        HStack(spacing: 0) {
            if attemptCase == .current {
                ForEach(mainViewModel.currentAttempt.attempt, id: \.self) { letter in
                    LetterView(letter: letter, status: letter == .empty ? .defaultStatus : .typing, index: 0)
                        .padding(.horizontal, 3)
                }
            } else {
                ForEach(0..<5, id: \.self) { _ in
                    LetterView(index: 0)
                        .padding(.horizontal, 3)
                }
            }
        }
        .phaseAnimator(ShakePhase.phases, trigger: mainViewModel.shouldShake) { content, phase in
            content
                .offset(x: phase.xOffset)
        } animation: { phase in
            .spring(duration: 0.1)
        }
    }
}

#Preview2 {
    AttemptView(attemptCase: .empty)
        .environmentObject(MainViewModel())
}

enum AttemptCase {
    case current, empty
}

enum ShakePhase {
    case left
    case right
    case done
    
    var xOffset: CGFloat {
        switch self {
            
        case .left: -5
        case .right: 5
        case .done: 0
        }
    }
    
    static var phases: [ShakePhase] {
        return [.done, .left, .right, .done]
    }
}
