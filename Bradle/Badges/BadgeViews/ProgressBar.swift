//
//  ProgressBar.swift
//  Bradle
//
//  Created by Brady Carden on 6/14/26.
//

import SwiftUI

struct ProgressBar: View {
    let currentVal: Int
    let targetVal: Int
    let size: BadgeSize
    
    init(currentVal: Int, targetVal: Int, size: BadgeSize = .small) {
        self.currentVal = currentVal
        self.targetVal = targetVal
        self.size = size
    }
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8 * size.constant)
                        .stroke(.white, lineWidth: size.constant)
                        .frame(height: 12.8 * size.constant)
                    
                    RoundedRectangle(cornerRadius: 8 * size.constant)
                        .fill(.white)
                        .frame(width: geometry.size.width * (CGFloat(currentVal) / CGFloat(targetVal) * 0.9))
                        .frame(height: 6.4  * size.constant)
                        .padding(.horizontal, 3.2 * size.constant)
                }
            }
            .frame(width: 32 * size.constant, height: 12.8 * size.constant)
            
            Text("\(currentVal.description)/\(targetVal.description)")
                .foregroundStyle(BradleColors.lightModeBackground)
                .font(.custom(FontNames.mediumFancy, size: Constants.badgeProgressFontSize * size.constant))
                .bold()
        }
    }
}

#Preview {
    VStack {
        ProgressBar(currentVal: 12, targetVal: 14)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.black)
}
