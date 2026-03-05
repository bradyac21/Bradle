//
//  RowView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct SubmittedAttemptView: View {
    var submittedAttempt: SubmittedAttempt
        
    @Environment(ColorManager.self) var colorManager
    @State var shouldFloat: Bool = false
    
    init(for attempt: SubmittedAttempt) {
        self.submittedAttempt = attempt
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { index in
                SubmittedLetterView(
                    letter: submittedAttempt.letters[index],
                    status: submittedAttempt.statuses[index],
                    index: index,
                    colorManager: colorManager
                )
                .floatAnimation(trigger: shouldFloat, index: index)
                .padding(.horizontal, 3)
            }
        }
        .onAppear {
            if submittedAttempt.isTarget {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    shouldFloat.toggle()
                }
            }
        }
    }
}

#Preview {
    SubmittedAttemptView(for: SubmittedAttempt())
        .environmentObject(GameRunner())
        .environment(ColorManager())
}
