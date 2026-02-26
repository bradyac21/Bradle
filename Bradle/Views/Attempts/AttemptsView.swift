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
                    SubmittedAttemptView(submittedAttempt: attempt)
                        .frame(height: geometry.size.width * (1/5))
                    
                }
                
                // Row for current attempt
                if !gameRunner.targetWordFound {
                    CurrentAttemptView()
                        .frame(height: geometry.size.width * (1/5))
                        .phaseAnimator(Shake.phases, trigger: gameRunner.shouldShake) { content, phase in
                            content
                                .offset(x: phase.xOffset)
                        } animation: { phase in
                                .spring(duration: 0.01)
                        }
                }
                
                // Remaining empty rows
                ForEach(0..<gameRunner.numEmptyRows, id: \.self) { _ in
                    EmptyAttemptView()
                        .frame(height: geometry.size.width * (1/5))
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
