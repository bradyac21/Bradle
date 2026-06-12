//
//  BadgesSheet.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct BadgesSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("All Badges")
                        .font(.custom(FontNames.mediumFancy, size: 25))
                        .foregroundStyle(.white)
                    
                    
                    Spacer()
                    
                    Button("dismiss", systemImage: "xmark") {
                        dismiss()
                    }
                    .labelStyle(.iconOnly)
                    .buttonStyle(.plain)
                    .foregroundStyle(BradleColors.lightModeNotIncluded)
                }
                                
                Spacer()
            }
            
            ScrollView {
                Text("Wordle")
                    .font(.custom(FontNames.mainTitle, size: 30))
                    .foregroundStyle(.white)
                    .padding(.bottom, 25)
                
                Text("Earned Badges")
                    .font(.custom(FontNames.mediumFancy, size: 15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                let earnedBadges = AccountStore.earnedBadges
                if earnedBadges.isEmpty {
                    Text("No earned badges!")
                        .font(.custom(FontNames.mediumFancy, size: 15))
                        .foregroundStyle(.white)
                        .padding(.vertical, 40)
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 40) {
                        ForEach(AccountStore.earnedBadges, id: \.self) { badge in
                            VStack {
                                badge.icon
                                Text(badge.rawValue)
                                    .font(.custom(FontNames.mediumFancy, size: 10))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
                
                Text("Unearned Badges")
                    .font(.custom(FontNames.mediumFancy, size: 15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                let unearnedBadges = AccountStore.unearnedBadges
                if unearnedBadges.isEmpty {
                    Text("You've earned all badges")
                        .font(.custom(FontNames.mediumFancy, size: 15))
                        .foregroundStyle(.white)
                        .padding(.top, 40)
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 40) {
                        ForEach(AccountStore.unearnedBadges, id: \.self) { badge in
                            VStack {
                                badge.icon
                                    .grayscale(1.0)
                                Text(badge.rawValue)
                                    .font(.custom(FontNames.mediumFancy, size: 10))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
            .padding(.top, 45)
        }
        .padding(.top, 30)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            BradleColors.darkModeBackground
        }
    }
}

#Preview {
    VStack{}
        .sheet(isPresented: .constant(true)) {
            BadgesSheet()
        }
}
