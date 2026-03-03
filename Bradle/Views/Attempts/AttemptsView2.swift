//
//  AttemptsView2.swift
//  Bradle
//
//  Created by Brady Carden on 3/3/26.
//

import SwiftUI

struct AttemptsView2: View {
    
    @EnvironmentObject var gameRunner: GameRunner2
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                
                // Rows for submitted attempts
                ForEach(gameRunner.attempts, id: \.attempt.id) { attempt in
                    AttemptRow(rowModel: attempt)
                        .frame(height: geometry.size.width * (1/5))
                }
                .padding(.horizontal, 3)
            }
        }
    }
}

// MARK: - Functions
#Preview {
    AttemptsView()
        .environmentObject(GameRunner())
}
