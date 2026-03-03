//
//  SubmittedLetterView2.swift
//  Bradle
//
//  Created by Brady Carden on 2/27/26.
//

import SwiftUI

struct SubmittedLetterView2: View {
    @State var status: SubmittedAttemptLetterStatus = .correct
    
    let letter: Letter
    let statusToChangeTo: SubmittedAttemptLetterStatus
    let index: Int
    let delay: CGFloat
    
    init(letter: Letter, statusToChangeTo: SubmittedAttemptLetterStatus, index: Int) {
        self.letter = letter
        self.statusToChangeTo = statusToChangeTo
        self.index = index
        self.delay = (CGFloat(index) * 0.4) + 0.2
    }
    
    var body: some View {
        LetterView2(letter: letter, status: status)
            .status(status)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    status = statusToChangeTo
                }
            }
    }
}

#Preview {
    SubmittedLetterView2(letter: .A, statusToChangeTo: .correct, index: 0)
}

extension LetterView2 {
    func status(_ status: Status) -> LetterView2 {
        LetterView2(letter: self.letter, status: status)
    }
}
