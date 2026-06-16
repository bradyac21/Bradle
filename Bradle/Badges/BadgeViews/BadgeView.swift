//
//  BadgeWrapper.swift
//  Bradle
//
//  Created by Brady Carden on 6/15/26.
//

import SwiftUI

struct BadgeView: View {
    let badge: Badge
    let earnedCount: Int
    
    
    var body: some View {
        VStack {
            badge.icon
            
            Text(badge.rawValue)
                .font(.custom(FontNames.mediumFancy, size: 10))
                .foregroundStyle(.white)
            
            Text("x\(earnedCount)")
                    .font(.custom(FontNames.mediumFancy, size: 8))
                    .frame(width: 35)
                    .background(.white, in: RoundedRectangle(cornerRadius: 10))
                    .opacity(earnedCount > 1 ? 1 : 0)
                
            if let (currentProgress, targetVal) = badge.badgeProgess {
                ProgressBar(currentVal: currentProgress, targetVal: targetVal)
                    .opacity(earnedCount > 1 ? 0 : 1)
                    .padding(.top, -15)
            }
        }
        .frame(alignment: .top)
    }
}

#Preview {
    VStack {
        BadgeView(badge: .fourteenDayStreak, earnedCount: 3)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(BradleColors.darkModeNotIncluded)
}
