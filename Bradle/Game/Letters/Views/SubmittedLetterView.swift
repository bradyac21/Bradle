//
//  SunmittedLetterView.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

struct SubmittedLetterView: View {
    var letter: Letter
    let letterSize: CGFloat
    var status: SubmittedStatus
    var index: CGFloat
    @State var flipTrigger: Bool = false
    @State var color: Color = .clear
    @State var borderColor: Color
    @State var letterColor: Color = .white
    
    @Environment(GameRunner.self) var gameRunner
    @Bindable var colorManager: ColorManager
    
    init(letter: Letter, letterSize: CGFloat = Constants.letterSize, status: SubmittedStatus, index: Int, colorManager: ColorManager) {
        self.letter = letter
        self.letterSize = letterSize
        self.status = status
        self.index = CGFloat(index)
        self.borderColor = colorManager.currentStatusBorderColors[safeKey: .filled]
        self.letterColor = colorManager.primary
        self._colorManager = Bindable(colorManager)
    }
    
    public var body: some View {
        
        // Wrap in Flip animation to dictate change of color
        PhaseAnimator(FlipAnimation.phases, trigger: flipTrigger) { phase in
            
            // Submitted Letter
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(color)
                    .strokeBorder(borderColor, lineWidth: 2)
                    .aspectRatio(1.0, contentMode: .fit)
                
                Text(letter.rawValue)
                    .font(.custom(FontNames.bold, size: letterSize))
                    .foregroundStyle(letterColor)
                    .padding(.bottom, 5)
            }
            
            // Flip effect
            .scaleEffect(y: phase.yScale)
            
            // Changes colors while tile is hidden
            .onChange(of: phase) { _, newValue in
                if newValue == .initial && index == 0 {
                    gameRunner.isKeyboardEnabled = false
                }
                
                if newValue == .end {
                    color = colorManager.submittedStatusColors[safeKey: status]
                    borderColor = .clear
                    
                    // Light mode needs a text color change
                    if !colorManager.darkModeEnabled {
                        letterColor = .white
                    }
                }
            }
        } animation: { phase in
            switch phase {
            case .initial:
                nil
            case .halfway:
                    .easeIn(duration: phase.duration).delay(Constants.letterFlipDuration * index)
            case .end:
                .easeOut(duration: phase.duration)
            }
        }
        
        .onAppear {
            // Trigger flip animation to reveal status
            flipTrigger.toggle()
        }
        
        // Have to explicitly listen for changes since fill color is changed during animation
        .onChange(of: colorManager.submittedStatusColors) { _, _ in
            color = colorManager.submittedStatusColors[safeKey: status]
        }
    }
}


#Preview {
    SubmittedLetterView(letter: .A, status: .correct, index: 0, colorManager: ColorManager())
        .environment(GameRunner())
        .environment(ColorManager())
}
