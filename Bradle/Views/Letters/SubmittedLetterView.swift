//
//  SunmittedLetterView.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

struct SubmittedLetterView: View {
    @State var flip: Bool = false
    @State var float: Bool = false
    @State var color: Color = .clear
    var letter: Letter
    var status: Status
    var index: CGFloat
    
    @EnvironmentObject var bradleViewModel: BradleViewModel
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1)
                .aspectRatio(1.0, contentMode: .fit)
                .border(color == .clear ? Color(UIColor.darkGray) : .clear)
                .foregroundStyle(color)
                .phaseAnimator(FrameFlip.phases, trigger: flip) { content, phase in
                    content
                        .scaleEffect(y: phase.yScale)
                } animation: { phase in
                        .easeInOut(duration: phase.duration).delay(getFlipDelay(for: phase))
                }
            Text(letter.rawValue)
                .font(.custom("NYTFranklin-Bold", size: 30))
                .foregroundStyle(.white)
                .phaseAnimator(LetterFlip.phases, trigger: flip) { content, phase in
                    content
                        .scaleEffect(y: phase.yScale)
                } animation: { phase in
                        .easeInOut(duration: phase.duration).delay(getFlipDelay(for: phase))
                }
        }
        
        // Flip animation on appear
        //.scaleEffect(x: 1, y: flip ? -1 : 1)
        // Float animation on success
        .phaseAnimator(FloatAnimation.phases, trigger: float) { content, phase in
            content.offset(y: phase.yOffset)
        } animation: { phase in
                .easeOut(duration: phase.duration).delay(getDelay(for: phase))
        }
        
        // Flip letters and show status on appear
        .onAppear {
            if index == 0 {
                bradleViewModel.pauseSubmit = true
            }
            withAnimation(.easeInOut(duration: 0.4).delay(0.4 * index)) {
                flip = true
            } completion: {
//                withAnimation(.linear(duration: 0)) {
//                    flip = false
//                }
                if index == 4 {
                    bradleViewModel.pauseSubmit = false
                }
                
                if bradleViewModel.targetWordFound {
                    float = true
                    if index == 4 {
                        bradleViewModel.setVictoryMessage()
                    }
                }
            }
            // Reveal status while frame is hidden during animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 + (0.4 * index)) {
                color = status.color
            }
        }
    }
}

extension SubmittedLetterView {
    func getFlipDelay(for phase: FrameFlip) -> CGFloat {
        return phase == .halfway ? 0.4 * index : 0
    }
    
    func getFlipDelay(for phase: LetterFlip) -> CGFloat {
        return phase == .halfway ? 0.4 * index : 0
    }
    
    func getDelay(for phase: FloatAnimation) -> CGFloat {
        return phase == .peak ? phase.delay - 0.3 * index : 0
    }
}

#Preview {
    SubmittedLetterView(letter: .A, status: .correct, index: 0)
        .environmentObject(BradleViewModel())
}
