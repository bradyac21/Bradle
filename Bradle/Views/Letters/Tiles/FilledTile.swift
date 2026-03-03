//
//  FilledTile.swift
//  Bradle
//
//  Created by Brady Carden on 3/3/26.
//

import SwiftUI

struct FilledTile: View {
    @Environment(ColorManager.self) var colorManager
    
    let letter: Letter
    let flipTrigger: Bool
    let flipDelay: CGFloat
    
    @State var shouldPop: Bool = false
    @Binding var doneAnimating: Bool
    @State var shouldFlip: Bool = false
    
    init(index: Int, letter: Letter, doneAnimating: Binding<Bool> = .constant(false), flipTrigger: Bool) {
        self.letter = letter
        self._doneAnimating = doneAnimating
        self.flipTrigger = flipTrigger
        self.flipDelay = CGFloat(index) * 0.4
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(.clear)
                .border(colorManager.filledBorder)
                .aspectRatio(1.0, contentMode: .fit)
            
            Text(letter.rawValue)
                .font(.custom("NYTFranklin-Bold", size: 30))
                .minimumScaleFactor(0.5)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 3)

        // Pop animation triggered with non-empty letter change
        .popAnimation(trigger: shouldPop)
        
        // Flip animation to hide FilledTile
        .scaleEffect(y: shouldFlip ? 0 : 1)
        .onChange(of: flipTrigger) { _, _ in
            withAnimation(.linear(duration: 0.2).delay(flipDelay)) {
                shouldFlip.toggle()
            } completion: {
                doneAnimating = true
            }
        }
        
        // Trigger pop on appear
        .onAppear {
            shouldPop.toggle()
        }
    }
}
