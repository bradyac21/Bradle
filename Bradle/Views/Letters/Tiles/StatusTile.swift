//
//  StatusTile.swift
//  Bradle
//
//  Created by Brady Carden on 3/3/26.
//

import SwiftUI

struct StatusTile: View {
    @Environment(ColorManager.self) var colorManager
    
    let letter: Letter
    let status: SubmittedAttemptLetterStatus
    let floatTrigger: Bool

    let flipDelay: CGFloat
    let floatDelay: CGFloat
    
    @State var shouldFlip: Bool = false
    
    init(index: Int, letter: Letter, status: SubmittedAttemptLetterStatus, floatTrigger: Bool) {
        self.letter = letter
        self.status = status
        self.floatTrigger = floatTrigger

        self.flipDelay = CGFloat(index) * 0.4
        self.floatDelay = CGFloat(index) * 0.1
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(colorManager.getBackgroundColor(for: status))
                .aspectRatio(1.0, contentMode: .fit)
            
            Text(letter.rawValue)
                .font(.custom("NYTFranklin-Bold", size: 30))
                .minimumScaleFactor(0.5)
                .foregroundStyle(.white)
                .padding(.bottom, 5)
        }
        .padding(.horizontal, 3)
        //.frame(height: 200)
        
        // Finish flip animation on appear to show status
        .scaleEffect(y: shouldFlip ? 1 : 0)
        .onAppear {
            withAnimation(.linear(duration: 0.2)) {
                shouldFlip.toggle()
            }
        }
        
        // Float animation for success
        .floatAnimation(using: floatTrigger, with: floatDelay)
    }
}
