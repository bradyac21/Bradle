//
//  CurrentAttemptLetterView.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

struct CurrentLetterView: View {
    var index: Int
    @State var shouldPop: Bool = false
    @State var borderColor: Color = BradleColors.lightGray
    
    @EnvironmentObject var gameRunner: GameRunner
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1)
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundStyle(.clear)
                .border(borderColor, width: 2)
                .popAnimation(trigger: shouldPop)
            
            Text(gameRunner.currentAttempt.attempt[index].rawValue)
                .font(.custom("NYTFranklin-Bold", size: 30))
                .foregroundStyle(.white)
        }
        .onChange(of: gameRunner.currentAttempt.attempt[index]) { _, newValue in
            if newValue != .empty {
                shouldPop.toggle()
                borderColor = BradleColors.lightGray
            } else {
                borderColor = BradleColors.darkGray
            }
        }
    }
}

private extension View {
    func popAnimation(trigger: Bool) -> some View {
        self
            .phaseAnimator(Pop.phases, trigger: trigger) { content, phase in
                content
                    .scaleEffect(phase.scale)
            } animation: { _ in
                .linear(duration: 0.025)
            }
    }
}

#Preview {
    CurrentLetterView(index: 0)
        .background {
            BradleColors.dark
        }
        .environmentObject(GameRunner())
}
