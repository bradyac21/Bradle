//
//  ContentView.swift
//  Wordle
//
//  Created by Brady Carden on 2/9/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                Text("This text is in the safe area.")
                    .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
