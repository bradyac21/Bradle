//
//  EmptyAttemptView.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

struct EmptyAttemptView: View {
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { _ in
                LetterView(index: 0)
                    .padding(.horizontal, 3)
            }
        }
    }
}

#Preview {
    EmptyAttemptView()
}
