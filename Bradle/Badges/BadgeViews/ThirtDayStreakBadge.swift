//
//  ThirtDayStreakBadge.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct ThirtyDayStreakBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    
    var body: some View {
        Image(systemName: "30.circle.fill")
            .foregroundStyle(BradleColors.yellow)
            .font(.system(size: Constants.badgeOuter * size.constant))
    }
}


struct ThirtyDayStreakPulseBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    
    var body: some View {
        Circle()
            .fill(BradleColors.yellow)
            .frame(width: Constants.badgeOuter * size.constant)
    }
}
