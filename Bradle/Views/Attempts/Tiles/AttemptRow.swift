//
//  AttemptRow.swift
//  Bradle
//
//  Created by Brady Carden on 3/3/26.
//

import SwiftUI

struct AttemptRow: View {
    @State var rowModel: AttemptRowModel
    
    var body: some View {
        HStack {
            ForEach(rowModel.attempt.attempt.enumerated(), id: \.offset) { index, letter in
                TileWrapper(
                    index: index,
                    letter: letter,
                    status: rowModel.statuses[index],
                    submitted: rowModel.isSubmitted,
                    correctGuess: rowModel.isCorrect,
                    doneAnimating: false
                )
            }
        }
    }
}

struct PreviewWrapper: View {
    @State var attemptRowModel = AttemptRowModel()
    
    var body: some View {
        ZStack {
            let colorManager = ColorManager()
            colorManager.gameBackground.ignoresSafeArea()
            
            VStack {
                Button("Submit") {
                    print("Submitting")
                    attemptRowModel.submit()
                }
                
                AttemptRow(rowModel: attemptRowModel)
                    .environment(colorManager)
            }
        }
    }
}

#Preview {
    PreviewWrapper()
}

struct AttemptRowModel: Identifiable {
    let id = UUID()
    var isCurrent: Bool
    var isSubmitted: Bool
    var attempt: Attempt
    var statuses: [SubmittedAttemptLetterStatus]
    var isCorrect: Bool
    
    init(isCurrent: Bool, isSubmitted: Bool, attempt: Attempt, statuses: [SubmittedAttemptLetterStatus], isCorrect: Bool) {
        self.isCurrent = isCurrent
        self.isSubmitted = isSubmitted
        self.attempt = attempt
        self.statuses = statuses
        self.isCorrect = isCorrect
    }
    
    init(isCurrent: Bool = false) {
        self.isCurrent = isCurrent
        self.isSubmitted = false
        self.attempt = Attempt()
        self.statuses = Array(repeating: .correct, count: 5)
        self.isCorrect = false
    }
    
    init() {
        self.isCurrent = false
        self.isSubmitted = false
        self.attempt = Attempt()
        self.statuses = Array(repeating: .unsubmitted, count: 5)
        self.isCorrect = false
    }
   
    mutating func submit() {
        isSubmitted.toggle()
    }
    
    func getTileModel(forIndex index: Int) -> TileModel {
        TileModel(
            index: index,
            letter: attempt.attempt[index],
            status: statuses[index],
            submitted: isSubmitted,
            correctGuess: isCorrect,
            doneAnimating: false
        )
    }
}
