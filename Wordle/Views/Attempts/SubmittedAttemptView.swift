//
//  RowView.swift
//  Wordle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct SubmittedAttemptView: View {
    var submittedAttempt: SubmittedAttempt
    @EnvironmentObject var mainViewModel: MainViewModel
    @State var shouldAnimate: Bool = false
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<submittedAttempt.attempt.count, id: \.self) { idx in
                LetterView(letter: submittedAttempt.attempt[idx], status: submittedAttempt.statuses[idx], index: idx)
                    .padding(.horizontal, 3)
                    
            }
        }
    }
}

//#Preview {
//    SubmittedAttemptView(attempt: Array(repeating: .A, count: 5))
//        .environmentObject(MainViewModel())
//}

