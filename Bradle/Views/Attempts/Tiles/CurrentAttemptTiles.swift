//
//  CurrentAttemptTiles.swift
//  Bradle
//
//  Created by Brady Carden on 3/3/26.
//

import SwiftUI

struct CurrentAttemptTiles: View {
    @EnvironmentObject var gameRunner: GameRunner
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { index in
                CurrentLetterView(index: index)
                    .padding(.horizontal, 3)
            }
        }
        
    }
}

#Preview {
    CurrentAttemptView()
        .environmentObject(GameRunner())
}
