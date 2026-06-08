//
//  EmptyLetterView.swift
//  Bradle
//
//  Created by Brady Carden on 3/4/26.
//

import SwiftUI

struct EmptyLetterView: View {
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1)
                .fill(.clear)
                .strokeBorder(colorManager.darkModeEnabled ? BradleColors.darkModeEmptyBorder : BradleColors.lightModeEmptyBorder, lineWidth: 2)
                .aspectRatio(1.0, contentMode: .fit)
        }
    }
}

#Preview {
    EmptyLetterView()
        .environment(ColorManager())
}
