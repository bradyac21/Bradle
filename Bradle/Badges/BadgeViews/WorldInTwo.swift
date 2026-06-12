//
//  Untitled.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct WordleInTwo: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(BadgeColors.gray)
                .frame(width: Constants.badgeOuter)
            Circle()
                .strokeBorder(.black, lineWidth: 2)
                .background(Circle().fill(BadgeColors.mint))
                .frame(width: Constants.badgeMiddle)
            Circle()
                .strokeBorder(.black, lineWidth: 3)
                .background(Circle().fill(BradleColors.yellow))
                .frame(width: Constants.badgeInner)
            Text("2")
                .font(.custom(FontNames.mainTitle, size: 22.5))
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 4, x: 0, y: 0)

        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        WordleInTwo()
    }
    
}
