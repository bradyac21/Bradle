//
//  ThirtDayStreakBadge.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct ThirtyDayStreakBadge: View {
    var body: some View {
        Image(systemName: "30.circle.fill")
            .foregroundStyle(BradleColors.yellow)
            .font(.system(size: Constants.badgeOuter))
    }
}
