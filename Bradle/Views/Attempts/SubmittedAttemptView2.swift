//
//  SubmittedAttemptView2.swift
//  Bradle
//
//  Created by Brady Carden on 2/27/26.
//

import SwiftUI

struct SubmittedAttemptView2: View {
    var attempt: [Letter]
    @State var statuses: [SubmittedAttemptLetterStatus]
    var isTarget: Bool
    
    @State var shouldFlip: Bool = false
    @State var shouldFloat: Bool = false
    
    @EnvironmentObject var gameRunner: GameRunner
    
    init(for submittedAttempt: SubmittedAttempt2) {
        guard submittedAttempt.attempt.count == 5 && submittedAttempt.statuses.count == 5 else {
            fatalError("Submitted Attempt did not have correct array lengths for variables")
        }
        
        self.attempt = submittedAttempt.attempt
        self.statuses = submittedAttempt.statuses
        self.isTarget = submittedAttempt.isTarget
    }
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { index in
                SubmittedLetterView2(
                    letter: attempt[index],
                    statusToChangeTo: statuses[index],
                    index: index
                )
                    .flipAnimation(trigger: shouldFlip, for: index)
                    .floatAnimation(trigger: shouldFloat, for: index)
                    .padding(.horizontal, 3)
            }
        }
        .onAppear {
            shouldFlip.toggle()
            
            if isTarget {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    shouldFloat.toggle()
                }
                
            // If the attempt is not the target, reenable the keyboard
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + FlipAnimation.totalDuration) {
                    gameRunner.enableKeyboard()
                }
            }
        }
    }
}

#Preview {
    ZStack {
        BradleColors.darkModeBackground.ignoresSafeArea()
        SubmittedAttemptView2(for: SubmittedAttempt2())
    }
        
}

private extension View {
    func flipAnimation(trigger: Bool, for index: Int) -> some View {
        return self
            .phaseAnimator(FlipAnimation.phases, trigger: trigger) { content, phase in
                content
                    .scaleEffect(y: phase.yScale)
            } animation: { phase in
                    .linear(duration: 0.2).delay(getFlipDelay(for: phase, using: index))
            }
    }
    
    
    func floatAnimation(trigger: Bool, for index: Int) -> some View {
        return self
            .phaseAnimator(FloatAnimation.phases, trigger: trigger) { content, phase in
                content.offset(y: phase.yOffset)
            } animation: { phase in
                    .easeOut(duration: phase.duration).delay(getFloatDelay(for: phase, using: index))
            }
    }
    
    func getFlipDelay(for phase: FlipAnimation, using index: Int) -> CGFloat {
        return phase == .halfway ? 0.4 * CGFloat(index) : 0
    }
    
    func getFloatDelay(for phase: FloatAnimation, using index: Int) -> CGFloat {
        return phase == .peak ? 0.1 * CGFloat(index) : 0
    }
}

enum SubmittedAttemptLetterStatus: StatusProtocol {
    /// This is used to transition from current attempt to submitted attempt
    case initial
    case notIncluded
    case included
    case correct
    
    /// Need to handle dark mode / light mode
    var backgroundColor: Color {
        switch self {
        case .initial:
            Color.clear
        case .notIncluded:
            BradleColors.darkModeNotIncluded
        case .included:
            BradleColors.yellow
        case .correct:
            BradleColors.green
        }
    }
    
    /// Need to handle dark mode / light mode
    var borderColor: Color {
        switch self {
        case .initial:
            BradleColors.darkModeFilledBorder
        case .notIncluded:
            BradleColors.darkModeNotIncluded
        case .included:
            BradleColors.yellow
        case .correct:
            BradleColors.green
        }
    }
}
