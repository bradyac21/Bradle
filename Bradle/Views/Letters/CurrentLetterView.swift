//
//  CurrentAttemptLetterView.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

struct CurrentLetterView: View {
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    
    var index: Int
    @State var shouldPop: Bool = false
    @State var borderColor: Color = .clear
    @State var status: Status = .empty
    
    @EnvironmentObject var gameRunner: GameRunner
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1)
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundStyle(.clear)
                .border(darkModeEnabled ? status.darkModeBorderColor : status.lightModeBorderColor)
                .popAnimation(trigger: shouldPop)
            
            Text(gameRunner.currentAttempt.attempt[index].rawValue)
                .font(.custom("NYTFranklin-Bold", size: 30))
                .foregroundStyle(darkModeEnabled ? .white : .black)
                .padding(.bottom, 5)
        }
        .onChange(of: gameRunner.currentAttempt.attempt[index]) { _, newValue in
            if newValue != .empty {
                shouldPop.toggle()
                status = .attemptInProgress
            } else {
                status = .empty
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
