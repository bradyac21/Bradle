//
//  KeyboardView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct KeyboardView: View {
    let rows: [[KeyboardButton]] = [
        Array(KeyboardButton.allCases[0..<10]),
        Array(KeyboardButton.allCases[10..<19]),
        Array(KeyboardButton.allCases[19...])
    ]
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(rows, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(row, id: \.self) { key in
                            KeyView(key: key)
                                .padding(3)
                                .frame(width: geometry.size.width * key.widthScale, height: geometry.size.width * 0.15)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    KeyboardView()
        .environmentObject(GameRunner())
}
