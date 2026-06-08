//
//  CurrentAttemptLetterView.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

struct CurrentLetterView: View {    
    var letter: Letter
    let letterSize: CGFloat
    @State var shouldPop: Bool = false
    @State var borderColor: Color = .clear
    @State var status: CurrentStatus = .empty
    
    @Environment(ColorManager.self) var colorManager
    
    init(letter: Letter, letterSize: CGFloat = Constants.letterSize) {
        self.letter = letter
        self.letterSize = letterSize
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(.clear)
                .strokeBorder(colorManager.currentStatusBorderColors[safeKey: status], lineWidth: 2)
                .aspectRatio(1.0, contentMode: .fit)
                .popAnimation(trigger: shouldPop)
            
            Text(letter.rawValue)
                .font(.custom(FontNames.bold, size: letterSize))
                .foregroundStyle(colorManager.primary)
                .padding(.bottom, 5)
        }
        
        // Trigger pop animation if letter is non-empty
        .onChange(of: letter) { _, newValue in
            if newValue != .empty {
                shouldPop.toggle()
                status = .filled
            } else {
                status = .empty
            }
        }
    }
}

#Preview {
    CurrentLetterView(letter: .A)
        .background {
            BradleColors.dark
        }
        .environment(GameRunner())
        .environment(ColorManager())
}
