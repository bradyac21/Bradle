//
//  HowToPlaySheet.swift
//  Bradle
//
//  Created by Brady Carden on 2/11/26.
//

import SwiftUI

struct HowToPlaySheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ColorManager.self) var colorManager
    
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
                    .font(.custom(FontNames.mainTitle, size: 30))
                
                // Guess the bradle in 6 tries
                Text("Guess the Bradle in 6 tries.")
                    .font(.custom(FontNames.cowboy, size: 17))
                    .padding(.top, -12)
                
                // 2 bullet points
                BulletPoint(text: "Each guess must be a valid 5-letter word.")
                BulletPoint(text: "The color of the tiles will change to show\n   how close your guess was to the word.")
                
                // Examples label
                Text("Examples")
                    .font(.custom(FontNames.bold, size: 15))
                    .padding(.top, 5)

                // WORDY
                WordyExampleWord(colorManager: colorManager)
                ExampleWordMessage(letter: .W, message: "is in the word and in the correct spot.")

                // LIGHT
                LightExampleWord(colorManager: colorManager)
                ExampleWordMessage(letter: .I, message: "is in the word but in the wrong spot.")

                // ROGUE
                RogueExampleWord(colorManager: colorManager)
                ExampleWordMessage(letter: .U, message: "is not in the word in any spot.")
 
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
                        .font(.custom(FontNames.normal, size: 15))
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
                    .font(.custom(FontNames.normal, size: 15))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.top, 20)
        .foregroundStyle(colorManager.primary)
        .background(colorManager.gameBackground)
    }
}

#Preview {
    HowToPlaySheet()
        .environment(ColorManager())
}

private struct BulletPoint: View {
    @Environment(ColorManager.self) var colorManager
    var text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("• \(text)")
                .font(.custom(FontNames.normal, size: 15))
                .fixedSize(horizontal: false, vertical: true)
        }
        .foregroundStyle(colorManager.primary)
        .padding(.top, 5)
    }
}

private struct ExampleWordMessage: View {
    let letter: Letter
    let message: String
    
    var body: some View {
        HStack(spacing: 0) {
            Text(letter.rawValue)
                .font(.custom(FontNames.bold, size: 15))
                .padding(.horizontal, 0)
                .padding(.bottom, 2)
            Text(" \(message)")
                .font(.custom(FontNames.normal, size: 15))
                .padding(.horizontal, 0)
        }
    }
}

private struct WordyExampleWord: View {
    @Bindable var colorManager: ColorManager
    
    init(colorManager: ColorManager) {
        self._colorManager = Bindable(colorManager)
    }
    
    var body: some View {
            HStack {
                SubmittedLetterView(letter: .W, status: .correct, index: 0, colorManager: colorManager)
                CurrentLetterView(letter: .O)
                CurrentLetterView(letter: .R)
                CurrentLetterView(letter: .D)
                CurrentLetterView(letter: .Y)
            }
            .frame(width: 200)
    }
}

private struct LightExampleWord: View {
    @Bindable var colorManager: ColorManager
    
    init(colorManager: ColorManager) {
        self._colorManager = Bindable(colorManager)
    }
    
    var body: some View {
        HStack {
            CurrentLetterView(letter: .L)
            SubmittedLetterView(letter: .I, status: .included, index: 0, colorManager: colorManager)
            CurrentLetterView(letter: .G)
            CurrentLetterView(letter: .H)
            CurrentLetterView(letter: .T)
        }
        .frame(width: 200)
        
    }
}

private struct RogueExampleWord: View {
    @Bindable var colorManager: ColorManager
    
    init(colorManager: ColorManager) {
        self._colorManager = Bindable(colorManager)
    }
    
    var body: some View {
        HStack {
            CurrentLetterView(letter: .R)
            CurrentLetterView(letter: .O)
            CurrentLetterView(letter: .G)
            SubmittedLetterView(letter: .U, status: .notIncluded, index: 0, colorManager: colorManager)
            CurrentLetterView(letter: .E)
        }
        .frame(width: 200)
        
    }
}
