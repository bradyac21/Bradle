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
    let progressWidth: CGFloat
    
    init(currentVal: Int, targetVal: Int) {
        self.currentVal = currentVal
        self.targetVal = targetVal
        self.progressWidth = CGFloat(24 * (Float(currentVal) / Float(targetVal)))
    }
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white)
                        .frame(height: 12.8)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white)
                        .frame(width: geometry.size.width * CGFloat(currentVal) / CGFloat(targetVal))
                        .frame(height: 6.4)
                        .padding(.horizontal, 3.2)
                }
            }
            .frame(width: 32, height: 12.8)
            Text("\(currentVal.description)/\(targetVal.description)")
                .foregroundStyle(BradleColors.lightModeBackground)
                .font(.custom(FontNames.mediumFancy, size: Constants.badgeProgressFontSize))
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
