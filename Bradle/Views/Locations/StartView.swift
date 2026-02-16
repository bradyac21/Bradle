//
//  StartView.swift
//  Bradle
//
//  Created by Brady Carden on 2/9/26.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var bradleViewModel: BradleViewModel
    
    var body: some View {
        ZStack {
            lightBackdround.ignoresSafeArea()
            VStack {
                Spacer()
                // Bradle logo
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                // Bradle title
                Text("Bradle")
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
                BradleButtonLabel("Play", fill: true) {
                    bradleViewModel.location = .game
                }
                
                // Log in
                BradleButtonLabel("Log in") {
                    bradleViewModel.sheet = .login
                }
                
                // Subscribe
                BradleButtonLabel("Subscribe") {
                    print("Subscribe tapped")
                }
                
                Spacer()
                
                // Date
                Text(Date().formatted(date: .long, time: .omitted))
                Text("Created by Brady Carden")
                    .fontWeight(.light)
                    .font(.system(size: 15))
                
                Spacer()
            }
        }.onAppear {
            for family in UIFont.familyNames.sorted() {
                        print("Family: \(family)")
                        for name in UIFont.fontNames(forFamilyName: family) {
                            print("   \(name)")
                        }
                    }
        }
    }
}

#Preview {
    StartView()
        .environmentObject(BradleViewModel())
}

struct BradleButtonLabel: View {
    var label: String
    var fill: Bool = false
    var action: () -> Void
    
    init(_ label: String, fill: Bool = false, action: @escaping () -> Void) {
        self.label = label
        self.fill = fill
        self.action = action
    }
    
    var body: some View {
        Text(label)
            .foregroundStyle(fill ? .white : bradleDarkGray)
            .frame(width: 150, height: 20)
            .padding(.vertical, 12.5)
            .background {
                Capsule()
                    .stroke(bradleDarkGray, lineWidth: 2)
                    .fill(fill ? bradleDarkGray : lightBackdround)
            }
            .onTapGesture {
                action()
            }
    }
}
