//
//  RowsFile.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct AttemptsView: View {
    
    let range = 0..<0
    
    @EnvironmentObject var gameRunner: GameRunner
    @Environment(ColorManager.self) var colorManager
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                // Rows for submitted attempts
                ForEach(gameRunner.submittedAttempts) { attempt in
                    SubmittedAttemptView(for: attempt)
                        .setAttemptRowHeight(using: geometry)
                    
                }
                
                // Row for current attempt
                if !gameRunner.gameComplete {
                    CurrentAttemptView()
                        .setAttemptRowHeight(using: geometry)
                        .shakeAnimation(trigger: gameRunner.shouldShake)
                }
                
                // Remaining empty rows
                ForEach(0..<gameRunner.numEmptyRows, id: \.self) { _ in
                    EmptyAttemptView()
                        .setAttemptRowHeight(using: geometry)
                }
                Spacer()
            }
            .padding(.horizontal, 3)
        }
    }
}

// MARK: - Functions
#Preview {
    AttemptsView()
        .environmentObject(GameRunner())
        .environment(ColorManager())
}

extension View {
    /// Constrains height of attempt rows in AttemptsView
    func setAttemptRowHeight(using geometry: GeometryProxy) -> some View {
        frame(height: geometry.size.width * (1/5))
    }
}
