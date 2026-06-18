//
//  WordleInOne.swift
//  Bradle
//
//  Created by Brady Carden on 6/11/26.
//

import SwiftUI

struct WordleInOneBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(BradleColors.green.opacity(0.25))
                .frame(width: Constants.badgeOuter * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 2)
                .background(Circle().fill(BradleColors.yellow))
                .frame(width: Constants.badgeMiddle * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 3)
                .background(Circle().fill(BradleColors.green))
                .frame(width: Constants.badgeInner * size.constant)
            Text("1")
                .font(.custom(FontNames.mainTitle, size: 22.5 * size.constant))
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 4, x: 0, y: 0)
        }
        .frame(width: Constants.badgeOuter * size.constant, height: Constants.badgeOuter * size.constant)
    }
}

#Preview {
    WordleInOneBadge()
}

struct WordleInOnePulseBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(BradleColors.green.opacity(0.25))
                .frame(width: Constants.badgeOuter * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 2)
                .background(Circle().fill(BradleColors.yellow))
                .frame(width: Constants.badgeMiddle * size.constant)
            Circle()
                .strokeBorder(.black, lineWidth: 3)
                .background(Circle().fill(BradleColors.green))
                .frame(width: Constants.badgeInner * size.constant)
        }
        .frame(width: Constants.badgeOuter * size.constant, height: Constants.badgeOuter * size.constant)
    }
}
