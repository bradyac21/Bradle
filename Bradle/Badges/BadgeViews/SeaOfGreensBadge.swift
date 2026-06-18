//
//  SeaOfGreensBadge.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct SeaOfGreensBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(BradleColors.yellow)
                .frame(width: Constants.badgeOuter * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 2)
                .background(Circle().fill(.white))
                .frame(width: Constants.badgeMiddle * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 3)
                .background(Circle().fill(BradleColors.green))
                .frame(width: Constants.badgeInner * size.constant)
            Image(systemName: "water.waves")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 20 * size.constant)
        }
        .frame(width: Constants.badgeOuter * size.constant, height: Constants.badgeOuter * size.constant)
    }
}

#Preview {
    ZStack {
        BradleColors.darkModeBackground.ignoresSafeArea()
        SeaOfGreensBadge()

    }
}

struct SeaOfGreensPulseBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(BradleColors.yellow)
                .frame(width: Constants.badgeOuter * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 2)
                .background(Circle().fill(.white))
                .frame(width: Constants.badgeMiddle * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 3)
                .background(Circle().fill(BradleColors.green))
                .frame(width: Constants.badgeInner * size.constant)
        }
        .frame(width: Constants.badgeOuter * size.constant, height: Constants.badgeOuter * size.constant)
    }
}
