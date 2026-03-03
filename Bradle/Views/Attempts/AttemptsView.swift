//
//  RowsFile.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct AttemptsView: View {
    
    @EnvironmentObject var gameRunner: GameRunner
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                
                // Rows for submitted attempts
                ForEach(gameRunner.submittedAttempts, id: \.attempt.self) { attempt in
                    SubmittedAttemptView(for: attempt)
                        .setAttemptRowHeight(using: geometry)
                    
                }
                
                // Row for current attempt
                if !gameRunner.targetWordFound {
                    CurrentAttemptView()
                        .setAttemptRowHeight(using: geometry)
                        .shakeAnimation(trigger: gameRunner.shouldShake)
                }
                
                // Remaining empty rows
                ForEach(0..<gameRunner.numEmptyRows, id: \.self) { _ in
                    EmptyAttemptView()
                        .setAttemptRowHeight(using: geometry)
                }
            }
            .padding(.horizontal, 3)
        }
    }
}

// MARK: - Functions
#Preview {
    AttemptsView()
        .environmentObject(GameRunner())
}

extension View {
    func shakeAnimation(trigger: Bool) -> some View {
        phaseAnimator(Shake.phases, trigger: trigger) { content, phase in
            content
                .offset(x: phase.xOffset)
        } animation: { phase in
                .spring(duration: 0.01)
        }
    }
    
    func setAttemptRowHeight(using geometry: GeometryProxy) -> some View {
        frame(height: geometry.size.width * (1/5))
    }
}
