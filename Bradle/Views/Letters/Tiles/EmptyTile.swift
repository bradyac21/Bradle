//
//  EmptyTile.swift
//  Bradle
//
//  Created by Brady Carden on 3/3/26.
//

import SwiftUI

struct EmptyTile: View {
    
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(.clear)
            .border(colorManager.emptyBorder)
            .aspectRatio(1.0, contentMode: .fit)
            .padding(.horizontal, 3)
            //.frame(height: 200, alignment: .top)
    }
}
