//
//  EmptyAttemptTiles.swift
//  Bradle
//
//  Created by Brady Carden on 3/3/26.
//

import SwiftUI

let wordLengthRange = 0..<5

struct EmptyAttemptTiles: View {
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(wordLengthRange, id: \.self) { _ in
                EmptyTile()
                    .padding(.horizontal, 3)
            }
        }
    }
}

#Preview {
    var colorManager = ColorManager()
    ZStack {
        colorManager.gameBackground.ignoresSafeArea()
        EmptyAttemptTiles()
            .environment(colorManager)
    }
}
