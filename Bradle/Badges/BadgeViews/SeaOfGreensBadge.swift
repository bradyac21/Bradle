//
//  SeaOfGreensBadge.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct SeaOfGreensBadge: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(BadgeColors.mint)
                .frame(width: Constants.badgeOuter)
            Circle()
                .strokeBorder(.black, lineWidth: 2)
                .background(Circle().fill(BadgeColors.gray))
                .frame(width: Constants.badgeMiddle)
            Circle()
                .strokeBorder(.black, lineWidth: 3)
                .background(Circle().fill(BradleColors.green))
                .frame(width: Constants.badgeInner)
            Image(systemName: "water.waves")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 20)

        }
    }
}

#Preview {
    ZStack {
        BradleColors.darkModeBackground.ignoresSafeArea()
        SeaOfGreensBadge()

    }
}
