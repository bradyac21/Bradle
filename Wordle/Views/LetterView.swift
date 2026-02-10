//
//  RowView.swift
//  Wordle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct LetterView: View {
    var letter: Letter = .empty
    var status: Status = .defaultStatus
    @State var animate: Bool = false
    var index: Int
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    public var body: some View {
        ZStack {
            AnyView(status.background)
                .phaseAnimator(PopPhase.phases, trigger: animate) { content, phase in
                    content
                        .scaleEffect(phase.scale)
                } animation: { _ in
                    .linear(duration: 0.025)
                }
            Text(letter.rawValue)
                .font(.system(size: 30))
                .foregroundStyle(.white)
        }
        .onAppear {
            animate = true
        }
    }
}

enum PopPhase {
    case normal, out
    
    var scale: CGFloat {
        switch self {
            
        case .normal:
            return 1.0
        case .out:
            return 1.05
        }
    }
    
    static var phases: [PopPhase] {
        [.normal, .out, .normal]
    }
}


#Preview {
    LetterView(letter: .A, index: 0)
        .environmentObject(MainViewModel())
}
