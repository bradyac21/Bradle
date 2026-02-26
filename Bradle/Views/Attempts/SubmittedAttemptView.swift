//
//  RowView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct SubmittedAttemptView: View {
    var submittedAttempt: SubmittedAttempt
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(submittedAttempt.attempt.enumerated()), id: \.offset) { index, letter in
                SubmittedLetterView(letter: letter, status: submittedAttempt.statuses[index], index: CGFloat(index))
                    .padding(.horizontal, 3)
            }
        }
    }
}

#Preview {
    let attempt: [Letter] = [.B, .R, .A, .D, .Y]
    let status: [Status] = [.included, .notIncluded, .notIncluded, .correct, .notIncluded]
    
    SubmittedAttemptView(submittedAttempt: SubmittedAttempt(attempt: attempt, statuses: status))
        .environmentObject(GameRunner())
}

