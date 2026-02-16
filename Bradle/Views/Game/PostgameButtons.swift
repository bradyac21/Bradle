//
//  PostgameButtons.swift
//  Bradle
//
//  Created by Brady Carden on 2/14/26.
//

import SwiftUI

struct PostgameButtons: View {
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                print("See results tapped")
            }, label: {
                Text("See results")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 87)
                    .padding(.vertical, 8)
                    .background {
                        Capsule()
                            .stroke(.white)
                    }
            })
            .buttonStyle(.plain)
            .padding(.bottom, 5)
            
            Button(action: {
                print("Play the Bradle Archive tapped")
            }, label: {
                Text("Play the Bradle Archive")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 8)
                    .background {
                        Capsule()
                            .stroke(.white)
                    }
            })
            .buttonStyle(.plain)
            Spacer()
        }
    }
}
