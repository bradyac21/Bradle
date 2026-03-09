//
//  ResultsView.swift
//  Bradle
//
//  Created by Brady Carden on 3/1/26.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    
    // Pull from somewhere
    let stats = [Stat(8, "Played"), Stat(100, "Win %"), Stat(2, "Current Streak"), Stat(4, "Max Streak")]
    
    var body: some View {
        ZStack {
            darkModeEnabled ? BradleColors.darkModeBackground.ignoresSafeArea() : BradleColors.lightModeBackground.ignoresSafeArea()
            
            VStack {
                
                // Dismiss buttons
                HStack {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Back to puzzle")
                            .bold()
                        Image(systemName: "xmark")
                            .padding(.leading, 2)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(darkModeEnabled ? .white : .black)
                }
                
                // Star thing
                StarThing()
                
                // Congratulations
                Text("Congratulations!")
                    .font(.custom(FontNames.mainTitle, size: 30))
                    .padding(.bottom, 5)
                
                // Stats label
                HStack {
                    Text("STATISTICS")
                        .font(.custom(FontNames.bold, size: 15))
                    
                    Spacer()
                }
                .padding(.bottom, 10)
                                
                // Statistics
                HStack(alignment: .center) {
                    ForEach(stats, id: \.self) { stat in
                        StatView(stat: stat)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // Guess Distribution
                HStack {
                    Text("GUESS DISTRIBUTION")
                        .font(.custom(FontNames.bold, size: 15))
                    
                    Spacer()
                }
                
                GuessDistView()
                
                // Wordle bot
                
                // Custom puzzle, share
                
                // Share button
                
                // Explore wordle archive
                
                Spacer()
            }
            .foregroundStyle(darkModeEnabled ? .white : .black)
            .padding()
            
        }
    }
}

#Preview {
    GameView()
        .sheet(isPresented: .constant(true)) {
            ResultsView()
        }
        .environmentObject(GameRunner())
        .environment(ColorManager())
}

struct Stat: Hashable {
    let value: Int
    let label: String
    
    init(_ value: Int, _ label: String) {
        self.value = value
        self.label = label
    }
}

struct StatView: View {
    let stat: Stat
    var body: some View {
        VStack {
            Text(stat.value.description)
                .font(.system(size: 30))
                .frame(height: 30)
            Text(stat.label)
                .font(.custom(FontNames.normal, size: 10))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .frame(height: 40, alignment: .top)
        }
        .frame(width: 75)
    }
}

struct GuessDistView: View {
    
    let recentGuess = 3
    //@State var account = BradleAccount()
    @State var histogram = [Int: Int]()
    
    var body: some View {
        VStack(alignment: .leading) {
//            ForEach(1..<7) { index in
//                HStack {
//                    Text(index.description)
//                        .font(.system(size: 15))
//                        .frame(width: 10)
//                        .bold()
//                    Rectangle()
//                        .fill(index == recentGuess ? BradleColors.green : BradleColors.darkModeFilledBorder)
//                        .containerRelativeFrame(.horizontal) { width, _ in
//                            if let indexWinTotal = histogram[index], let histMax = histogram.values.max() {
//                                let factor = Float(indexWinTotal) / (Float(histMax) * 1.25)
//                                return width * CGFloat(factor)
//                            } else {
//                                return 20
//                            }
//                        }
//                        
//                        .overlay {
//                            Text((histogram[index] ?? 0).description)
//                                .font(.system(size: 15))
//                                .padding(.trailing, 6)
//                                .padding(.bottom, 1)
//                                .frame(maxWidth: .infinity, alignment: .trailing)
//                            
//                        }
//                }
//                .frame(height: 20)
//            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
           // histogram = account.getGuessDistribution()
        }
    }
}
