//
//  SunmittedLetterView.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

struct SubmittedLetterView: View {
    @State var shouldFlip: Bool = false
    @State var shouldFloat: Bool = false
    @State var color: Color = .clear
    @State var showBorder: Bool = true
    var letter: Letter
    var status: Status
    var index: CGFloat
    
    @EnvironmentObject var gameRunner: GameRunner
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1)
                .aspectRatio(1.0, contentMode: .fit)
                .border(showBorder ? BradleColors.darkGray : .clear)
                .foregroundStyle(color)
                .scaleEffect(x: 1, y: shouldFlip ? -1 : 1)

            Text(letter.rawValue)
                .font(.custom("NYTFranklin-Bold", size: 30))
                .foregroundStyle(.white)
                .phaseAnimator(LetterFlip.phases, trigger: shouldFlip) { content, phase in
                    content
                        .scaleEffect(y: phase.yScale)
                } animation: { phase in
                        .linear(duration: 0.2).delay(getFlipDelay(for: phase))
                }
        }
        
        // Perform float animation when submitted word is target word
        .phaseAnimator(FloatAnimation.phases, trigger: shouldFloat) { content, phase in
            content.offset(y: phase.yOffset)
        } animation: { phase in
            .easeOut(duration: phase.duration).delay(getFloatDelay(for: phase))
        }
        
        // Perform flip animation on appear, reveal letter status
        .onAppear {
            withAnimation(.linear(duration: 0.4).delay(0.4 * index)) {
                shouldFlip = true
            } completion: {
                // Keyboard input is disabled while submission is being revealed
                if index == 4 {
                    gameRunner.disableKeyboardInput = false
                }
                
                // Trigger float animation is submitted word is target word
                if gameRunner.targetWordFound {
                    shouldFloat = true
                    if index == 4 {
                        gameRunner.setVictoryMessage()
                    }
                }
            }
            // Change status color while frame is hidden during animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 + (0.4 * index)) {
                color = status.color
                showBorder = false
            }
        }
    }
}

//private extension View {
//    func floatAnimation(trigger: Bool, delay: CGFloat) -> some View {
//        self
//            .phaseAnimator(FloatAnimation.phases, trigger: trigger) { content, phase in
//                content.offset(y: phase.yOffset)
//            } animation: { phase in
//                    .easeOut(duration: phase.duration).delay(delay)
//            }
//    }
//}

extension SubmittedLetterView {
    func getFlipDelay(for phase: LetterFlip) -> CGFloat {
        return phase == .halfway ? 0.4 * index : 0
    }
    
    func getFloatDelay(for phase: FloatAnimation) -> CGFloat {
        return phase == .peak ? phase.delay - 0.3 * index : 0
    }
}

#Preview {
    SubmittedLetterView(letter: .A, status: .correct, index: 0)
        .environmentObject(GameRunner())
}
