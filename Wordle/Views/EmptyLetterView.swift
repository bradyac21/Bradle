//
//  EmptyLetterView.swift
//  Wordle
//
//  Created by Brady Carden on 1/25/26.
//

import SwiftUI

struct EmptyLetterView: View {
    public var body: some View {
        LetterView(letter: .empty, status: .defaultStatus, index: 0)
    }
}
