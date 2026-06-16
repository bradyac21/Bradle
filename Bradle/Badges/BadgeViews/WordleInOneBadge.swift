//
//  WordleInOne.swift
//  Bradle
//
//  Created by Brady Carden on 6/11/26.
//

import SwiftUI

struct WordleInOneBadge: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(BradleColors.green.opacity(0.25))
                .frame(width: Constants.badgeOuter)
            Circle()
                .strokeBorder(.black, lineWidth: 2)
                .background(Circle().fill(BradleColors.yellow))
                .frame(width: Constants.badgeMiddle)
            Circle()
                .strokeBorder(.black, lineWidth: 3)
                .background(Circle().fill(BradleColors.green))
                .frame(width: Constants.badgeInner)
            Text("1")
                .font(.custom(FontNames.mainTitle, size: 22.5))
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 4, x: 0, y: 0)

        }
        .frame(width: Constants.badgeOuter, height: Constants.badgeOuter)
    }
}

#Preview {
    WordleInOneBadge()
}
