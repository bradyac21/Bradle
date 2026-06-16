//
//  FifteenHundredWordles.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct FifteenHundredWordlesBadge: View {
    var body: some View {
        ZStack {
            Image(systemName: "hexagon.fill")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: Constants.badgeOuter)
                .foregroundStyle(BradleColors.yellow)
            Image(systemName: "hexagon")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)

                .frame(width: Constants.badgeMiddle)
                .foregroundStyle(BradleColors.green)
            Text("1500")
                .font(.custom(FontNames.mainTitle, size: 17.5))
        }
    }
}

#Preview {
    FifteenHundredWordlesBadge()
}
