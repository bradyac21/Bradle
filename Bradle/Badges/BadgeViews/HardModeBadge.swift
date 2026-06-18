//
//  HardModeBadge.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct HardModeBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    var body: some View {
        Image(systemName: "helmet.fill")
            .foregroundStyle(BradleColors.green)
            .font(.system(size: Constants.badgeOuter * size.constant))
    }
}
