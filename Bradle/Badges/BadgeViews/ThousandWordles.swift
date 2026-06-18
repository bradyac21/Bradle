//
//  ThousandWordles.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct ThousandWordlesBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Image(systemName: "hexagon.fill")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: Constants.badgeOuter * size.constant)
                .foregroundStyle(BradleColors.green)
            Image(systemName: "hexagon")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: Constants.badgeMiddle * size.constant)
                .foregroundStyle(BradleColors.yellow)
            Text("1000")
                .font(.custom(FontNames.mainTitle, size: 17.5 * size.constant))
        }
    }
}

#Preview {
    ThousandWordlesBadge()
}

struct ThousandWordlesPulseBadge: View {
    let size: BadgeSize
    
    init(size: BadgeSize = .small) {
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Image(systemName: "hexagon.fill")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: Constants.badgeOuter * size.constant)
                .foregroundStyle(BradleColors.green)
            Image(systemName: "hexagon")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: Constants.badgeMiddle * size.constant)
                .foregroundStyle(BradleColors.yellow)
        }
    }
}
