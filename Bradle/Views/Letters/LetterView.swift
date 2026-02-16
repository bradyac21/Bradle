//
//  RowView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct LetterView: View {
    @State var letter: Letter = .empty {
        didSet {
            pop = true
        }
    }
    @State var status: Status = .defaultStatus {
        didSet {
            print("status change to \(status)")
            flip = true
        }
    }
    @State var flip: Bool = false
    @State var pop: Bool = false
    var index: Int = 0
    
    @EnvironmentObject var bradleViewModel: BradleViewModel
    
    public var body: some View {
        ZStack {
            AnyView(status.background)
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
                .foregroundStyle(.white)
        }
        .onAppear {
            pop.toggle()
        }
    }
}

#Preview {
    LetterView(letter: .A, index: 0)
        .environmentObject(BradleViewModel())
}
