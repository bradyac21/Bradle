//
//  StartView.swift
//  Wordle
//
//  Created by Brady Carden on 2/9/26.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            backgroundGray.ignoresSafeArea()
            NavigationView {
                VStack {
                    Spacer()
                    // Wordle logo
                    Image("Icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height:60)
                    
                    // Wordle title
                    Text("Wordle")
                        .font(.custom("AlfaSlabOne-Regular", size: 30))
                        .padding(.vertical, 10)
                    
                    // Get 6 chances to guess a
                    // 5-letter word.
                    Text("Get 6 chances to guess a\n 5-letter word.")
                        .lineSpacing(8)
                        .multilineTextAlignment(.center)
                        .font(.custom("K22 Karnak Deco", size: 20))
                        .padding(.bottom)
                    
                    
                    // Play button
                    NavigationLink(destination: MainView()) {
                        WordleButtonLabel("Play", fill: true)
                    }

                    
                    // Log in
                    WordleButtonLabel("Log in")
                    
                    // Subscribe
                    WordleButtonLabel("Subscribe")
                    
                    Spacer()
                    
                    // Date
                    Text(Date().formatted(date: .long, time: .omitted))
                    Text("Created by Brady Carden")
                        .fontWeight(.light)
                        .font(.system(size: 15))
                    
                    Spacer()
                }
            }
        }
   }
}

#Preview {
    StartView()
}

struct WordleButtonLabel: View {
    var label: String
    var fill: Bool = false
    
    init(_ label: String, fill: Bool = false,) {
        self.label = label
        self.fill = fill
    }
    
    var body: some View {
        Text(label)
            .foregroundStyle(fill ? .white : wordleDarkGray)
            .frame(width: 150, height: 20)
            .padding(.vertical, 12.5)
            .background {
                Capsule()
                    .stroke(wordleDarkGray, lineWidth: 2)
                    .fill(fill ? wordleDarkGray : backgroundGray)
            }
    }
}
