//
//  BadgesSheet.swift
//  Bradle
//
//  Created by Brady Carden on 6/12/26.
//

import SwiftUI

struct BadgesSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedBadge: Badge? = nil
    @State var earnedCount: Int = 0
    @State var badgeHeight: CGFloat = .zero
    
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
                        ForEach(AccountStore.earnedBadges, id: \.badge) { badge, count in
                            Button {
                                withAnimation {
                                    selectedBadge = badge
                                    earnedCount = count
                                }
                            } label: {
                                BadgeView(badge: badge, earnedCount: count)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 20)
                }
                
                Text("Unearned Badges")
                    .font(.custom(FontNames.mediumFancy, size: 15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                let unearnedBadges = Badge.allCases.filter { !earnedBadges.map { $0.badge }.contains($0) }
                if unearnedBadges.isEmpty {
                    Text("You've earned all badges!")
                        .font(.custom(FontNames.mediumFancy, size: 15))
                        .foregroundStyle(.white)
                        .padding(.top, 40)
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 40) {
                        ForEach(unearnedBadges, id: \.self) { badge in
                            Button {
                                withAnimation {
                                    selectedBadge = badge
                                }
                            } label: {
                                BadgeView(badge: badge, earnedCount: 0)
                                    .grayscale(1.0)
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
            .padding(.top, 45)
            
            
            if selectedBadge != nil {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .overlay {
                        VStack {
                            Button("dismiss badge screen", systemImage: "xmark") {
                                withAnimation {
                                    selectedBadge = nil
                                    earnedCount = 0
                                }
                            }
                            .padding(30)
                            .labelStyle(.iconOnly)
                            .buttonStyle(.plain)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundStyle(.white)
                            
                            Spacer()
                            
                            if let selectedBadge {
                                BadgeView(badge: selectedBadge, earnedCount: earnedCount)
                                    .scaleEffect(3.0)
                                    .grayscale(earnedCount == 0 ? 1.0 : 0.0)
                                    .onGeometryChange(for: CGFloat.self) { proxy in
                                        proxy.size.height
                                    } action: { height in
                                        badgeHeight = height
                                    }
                                
                                Text(selectedBadge.description(earnedCount: earnedCount))
                                    .multilineTextAlignment(.center)
                                    .padding(.top, badgeHeight + 20)
                                    .containerRelativeFrame(.horizontal) { width, _ in
                                        width * 0.75
                                    }
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                            Spacer()
                        }
                    }
                
            }
        }
        .padding(.top, selectedBadge == nil ? 30 : 0)
        .padding(.horizontal, selectedBadge == nil ? 30 : 0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BradleColors.darkModeBackground)
    }
}

#Preview {
    VStack{}
        .sheet(isPresented: .constant(true)) {
            BadgesSheet()
        }
}
