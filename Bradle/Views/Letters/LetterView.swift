//
//  RowView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct LetterView: View {
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    
    @State var letter: Letter = .empty
    @State var status: Status = .defaultStatus
    @State var flip: Bool = false
    @State var pop: Bool = false
    var index: Int = 0
    
    @EnvironmentObject var gameRunner: GameRunner
    
    public var body: some View {
        ZStack {
            AnyView(status.letterBackground)
                .phaseAnimator(Pop.phases, trigger: pop) { content, phase in
                    content
                        .scaleEffect(phase.scale)
                } animation: { _ in
                    .linear(duration: 0.025)
                }
                .scaleEffect(x: 1, y: flip ? -1 : 1)
                .animation(.easeInOut(duration: 0.4), value: flip)
            Text(letter.rawValue)
                .font(.custom("NYTFranklin-Bold", size: 30))
                .foregroundStyle(darkModeEnabled ? .white : BradleColors.lightModeBackground)
        }
        .onChange(of: letter) {
            pop = true
        }
        .onAppear {
            pop.toggle()
        }
    }
}

#Preview {
    LetterView(letter: .A, index: 0)
        .environmentObject(GameRunner())
}
