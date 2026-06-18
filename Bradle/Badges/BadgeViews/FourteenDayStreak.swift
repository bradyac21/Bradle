//
//  FourteenDayStreak.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct FourteenDayStreakBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    var body: some View {
        Image(systemName: "14.circle.fill").foregroundStyle(BradleColors.green)
            .font(.system(size: Constants.badgeOuter * size.constant))
    }
}

#Preview {
    VStack {
        FourteenDayStreakBadge()
        FourteenDayStreakPulseBadge()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray)
}


struct FourteenDayStreakPulseBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    var body: some View {
        Circle()
            .fill(BradleColors.green)
            .frame(width: Constants.badgeOuter * size.constant)
    }
}
