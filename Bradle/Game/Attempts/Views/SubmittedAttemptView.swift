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
            ForEach(0..<Constants.wordSize, id: \.self) { index in
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
                Task {
                    try? await Task.sleep(for: .seconds(Constants.floatDelay))
                    shouldFloat.toggle()
                }
            }
        }
    }
}

#Preview {
    SubmittedAttemptView(for: SubmittedAttempt())
        .environment(GameRunner())
        .environment(ColorManager())
}
