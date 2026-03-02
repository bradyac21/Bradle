//
//  StarThing.swift
//  Bradle
//
//  Created by Brady Carden on 3/1/26.
//

import SwiftUI

struct StarThing: View {
    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 80)
                .foregroundStyle(.green)
                .opacity(0.5)
            RoundedRectangle(cornerRadius: 0)
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 50)
                .foregroundStyle(.green)
            Image(systemName: "star.fill")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundStyle(.white)
                .frame(width: 40)
        }

    }
}

#Preview {
    StarThing()
}
