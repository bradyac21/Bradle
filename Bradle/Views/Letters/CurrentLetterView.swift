//
//  CurrentAttemptLetterView.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

struct CurrentLetterView: View {
    var index: Int
    @State var pop: Bool = false
    
    @EnvironmentObject var bradleViewModel: BradleViewModel
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1)
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundStyle(.clear)
                .border(Color(UIColor.darkGray), width: 1)
                .phaseAnimator(Pop.phases, trigger: pop) { content, phase in
                    content
                        .scaleEffect(phase.scale)
                } animation: { _ in
                    .linear(duration: 0.025)
                }
            Text(bradleViewModel.currentAttempt.attempt[index].rawValue)
                .font(.custom("NYTFranklin-Bold", size: 30))
                .foregroundStyle(.white)
        }
        .onChange(of: bradleViewModel.currentAttempt.attempt[index]) { _, newValue in
            if newValue != .empty {
                pop.toggle()
            }
        }
    }
}

#Preview {
    CurrentLetterView(index: 0)
        .background {
            darkBackground
        }
        .environmentObject(BradleViewModel())
}
