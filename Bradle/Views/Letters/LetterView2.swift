//
//  LetterView2.swift
//  Bradle
//
//  Created by Brady Carden on 2/27/26.
//

import SwiftUI

struct LetterView2<Status: StatusProtocol>: View {
    let letter: Letter
    var status: Status
        
    init(letter: Letter, status: Status = MyStatus.test) {
        self.letter = letter
        self.status = status
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(status.backgroundColor)
                .border(status.borderColor)
                .aspectRatio(1.0, contentMode: .fit)
            
            Text(letter.rawValue)
                .font(.custom("NYTFranklin-Bold", size: 30))
                .minimumScaleFactor(0.5)
                .foregroundStyle(.white)
                .padding(.bottom, 5)
        }
    }
}

#Preview {
    LetterView2(letter: .A, status: SubmittedAttemptLetterStatus.correct)
        .background {
            BradleColors.darkModeBackground.ignoresSafeArea()
        }
}

enum MyStatus: StatusProtocol {

    case test

    var backgroundColor: Color {
        .red
    }
    
    var borderColor: Color {
        .red
    }
    
    
}
