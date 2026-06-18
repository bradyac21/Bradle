//
//  Untitled.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct WordleInTwoBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.white)
                .frame(width: Constants.badgeOuter * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 2)
                .background(Circle().fill(BradleColors.green))
                .frame(width: Constants.badgeMiddle * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 3)
                .background(Circle().fill(BradleColors.yellow))
                .frame(width: Constants.badgeInner * size.constant)
            Text("2")
                .font(.custom(FontNames.mainTitle, size: 22.5 * size.constant))
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 4, x: 0, y: 0)
        }
        .frame(width: Constants.badgeOuter * size.constant, height: Constants.badgeOuter * size.constant)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        WordleInTwoBadge()
    }
}

struct WordleInTwoPulseBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.white)
                .frame(width: Constants.badgeOuter * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 2)
                .background(Circle().fill(BradleColors.green))
                .frame(width: Constants.badgeMiddle * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 3)
                .background(Circle().fill(BradleColors.yellow))
                .frame(width: Constants.badgeInner * size.constant)
        }
        .frame(width: Constants.badgeOuter * size.constant, height: Constants.badgeOuter * size.constant)
    }
}
