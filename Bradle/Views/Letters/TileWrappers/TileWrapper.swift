//
//  TileWrapper.swift
//  Bradle
//
//  Created by Brady Carden on 3/3/26.
//

import SwiftUI

struct TileWrapper: View {
    let index: Int
    let letter: Letter
    let status: SubmittedAttemptLetterStatus
    let submitted: Bool
    let correctGuess: Bool
    @State var doneAnimating: Bool
    
    var body: some View {
        if letter == .empty {
            EmptyTile()
        } else {
            if doneAnimating {
                StatusTile(
                    index: index,
                    letter: letter,
                    status: status,
                    floatTrigger: correctGuess
                )
            } else {
                FilledTile(
                    index: index,
                    letter: letter,
                    doneAnimating: $doneAnimating,
                    flipTrigger: submitted
                )
            }
        }
    }
}

struct TileModel {
    let index: Int
    let letter: Letter
    let status: SubmittedAttemptLetterStatus
    let submitted: Bool
    let correctGuess: Bool
    var doneAnimating: Bool
}
