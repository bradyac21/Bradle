//
//  HowToPlaySheet.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

struct HowToPlaySheet: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    var body: some View {
        VStack {
            
            // X button
            HStack {
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .padding()
            }
            
            VStack(alignment: .leading) {
                
                // How to play
                Text("How To Play")
                    .font(.karnakCondensedBold)
                
                // Guess the bradle in 6 tries
                Text("Guess the Bradle in 6 tries.")
                    .font(.custom("K22 Karnak Deco", size: 17))
                    .padding(.top, -12)
                
                // 2 bullet points
                BulletPoint(text: "Each guess must be a valid 5-letter word.")
                BulletPoint(text: "The color of the tiles will change to show\n   how close your guess was to the word.")
                
                // Examples label
                Text("Examples")
                    .font(.custom("NYTFranklin-Bold", size: 15))
                    .padding(.top, 5)
                
                // Wordy
                ExampleWord(
                    word: "WORDY",
                    status: .correct,
                    index: 0,
                    message: "is in the word and in the correct spot"
                )
                
                // LIGHT
                ExampleWord(
                    word: "LIGHT",
                    status: .included,
                    index: 1,
                    message: "is in the word but in the wrong spot."
                )
                
                // ROGUE
                ExampleWord(
                    word: "ROGUE",
                    status: .notIncluded,
                    index: 3,
                    message: "is not in the word in any spot."
                )
                
                // divider
                Divider()
                    .frame(height: 2)
                    .background(.white)
                    .padding(.top, 10)
                
                HStack {
                    Image(systemName: "person.crop.circle.fill.badge.checkmark")
                        .resizable()
                        .foregroundStyle(BradleColors.green)
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 25)
                        .padding(.trailing, 5)
                    Text("[Log in or create a free NYT account](#) to\nlink your stats")
                        .font(.custom("NYTFranklinCW-Normal", size: 15))
                        .lineSpacing(5)
                }
                .padding(.vertical, 8)
                
                
                // divider
                Divider()
                    .frame(height: 2)
                    .background(.white)
                    .padding(.bottom, 10)
                
                // a new puzzle...
                Text("A new puzzle is released daily at midnight. If you haven't already, you can sign up for our daily reminder email.")
                    .font(.custom("NYTFranklinCW-Normal", size: 15))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.top, 20)
        .foregroundStyle(darkModeEnabled ? .white : BradleColors.dark)
        .background {
            darkModeEnabled ? BradleColors.dark : BradleColors.light
        }
    }
}

#Preview {
    HowToPlaySheet()
}

struct BulletPoint: View {
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    var text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("• \(text)")
                .font(.custom("NYTFranklinCW-Medium", size: 15))
                .fixedSize(horizontal: false, vertical: true)
        }
        .foregroundStyle(darkModeEnabled ? .white : BradleColors.dark)
        .padding(.top, 5)
    }
}

struct ExampleWord: View {
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    var attempt: [Letter]
    var status: Status
    var index: Int
    var message: String
    
    init(word: String, status: Status, index: Int, message: String) {
        self.attempt = Letter.formTargetWord(from: word)
        self.status = status
        self.index = index
        self.message = message
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(Array(attempt.enumerated()), id: \.offset) { idx, letter in
                    LetterView(letter: letter, status: idx == index ? status : .attemptInProgress)
                }
            }
            HStack(spacing: 0) {
                
                Text(attempt.toString()[index].description)
                    .font(.custom("NYTFranklin-Bold", size: 15))
                    .padding(.horizontal, 0)
                Text(" \(message)")
                    .font(.custom("NYTFranklinCW-Medium", size: 15))
                    .padding(.horizontal, 0)
            }
        }
    }
}

extension String {
    subscript(i: Int) -> Character {
        self[index(startIndex, offsetBy: i)]
    }
}
