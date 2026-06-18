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
    let size: BadgeSize
    let shouldAnimate: Bool
    
    @State var isAnimating: Bool = false
    
    init(badge: Badge, earnedCount: Int, size: BadgeSize = .small, shouldAnimate: Bool = false) {
        self.badge = badge
        self.earnedCount = earnedCount
        self.size = size
        self.shouldAnimate = shouldAnimate
    }
    
    var body: some View {
        VStack {
            ZStack {
                if shouldAnimate {
                    badge.pulseIcon(size: size)
                        .scaleEffect(isAnimating ? 2.0 : 1.0)
                        .opacity(isAnimating ? 0.0 : 0.5)
                        .animation(
                            .easeOut(duration: 2.0)
                            .repeatForever(autoreverses: false),
                            value: isAnimating
                        )
                }
                badge.icon(size: size)
            }
            
            Text(badge.rawValue)
                .font(.custom(FontNames.mediumFancy, size: 10 * size.constant))
                .foregroundStyle(.white)
            
            Text("x\(earnedCount)")
                .font(.custom(FontNames.mediumFancy, size: 8 * size.constant))
                .frame(width: 35 * size.constant)
                .background(.white, in: RoundedRectangle(cornerRadius: 10 * size.constant))
                .opacity(earnedCount > 1 ? 1 : 0)
                
            if let (currentProgress, targetVal) = badge.badgeProgess {
                ProgressBar(currentVal: currentProgress, targetVal: targetVal, size: size)
                    .opacity(earnedCount > 1 ? 0 : 1)
                    .padding(.top, -15 * size.constant)
                    .padding(.bottom, 5)
            }
        }
        .onAppear {
            isAnimating.toggle()
        }
        .frame(alignment: .top)
    }
}

#Preview {
    VStack {
        BadgeView(badge: .hardMode, earnedCount: 0, size: .large)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(BradleColors.darkModeNotIncluded)
}
