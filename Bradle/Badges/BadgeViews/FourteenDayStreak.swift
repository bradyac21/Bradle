//
//  FourteenDayStreak.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct FourteenDayStreakBadge: View {
    var body: some View {
        Image(systemName: "14.circle.fill").foregroundStyle(BradleColors.green)
            .font(.system(size: Constants.badgeOuter))
    }
}

#Preview {
    FourteenDayStreakBadge()
}
