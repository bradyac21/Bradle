//
//  BradleColorsView.swift
//  Bradle
//
//  Created by Brady Carden on 3/2/26.
//
#if DEBUG

import SwiftUI

struct BradleColorsView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("light")
            RoundedRectangle(cornerRadius: 5)
                .fill(BradleColors.light)
                .constrain()
            
            Text("dark")
            RoundedRectangle(cornerRadius: 5)
                .fill(BradleColors.dark)
                .constrain()
            
            Spacer()
        }
        .navigationTitle("Bradle Colors")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#endif
