//
//  HardModeBadge.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct HardModeBadge: View {
    var body: some View {
        Image(systemName: "helmet.fill")
            .foregroundStyle(BradleColors.green)
            .font(.system(size: Constants.badgeOuter))
    }
}
