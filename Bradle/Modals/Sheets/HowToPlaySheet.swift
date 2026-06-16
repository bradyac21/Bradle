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
            
            Button("Dismiss", systemImage: "xmark") {
                dismiss()
            }
            .labelStyle(.iconOnly)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
            VStack(alignment: .leading) {
                
                Text("How To Play")
                    .font(.custom(FontNames.mainTitle, size: 30))
                    .padding(.bottom, 12)
                
                Text("Guess the Bradle in 6 tries.")
                    .font(.custom(FontNames.cowboy, size: 17))
                
                BulletPoint(text: "Each guess must be a valid 5-letter word.")
                BulletPoint(text: "The color of the tiles will change to show\n   how close your guess was to the word.")
                
                Text("Examples")
                    .font(.custom(FontNames.bold, size: 15))
                    .padding(.top, 5)

                WordyExampleWord()
                ExampleWordMessage(letter: .W, message: "is in the word and in the correct spot.")

                LightExampleWord()
                ExampleWordMessage(letter: .I, message: "is in the word but in the wrong spot.")

                RogueExampleWord()
                ExampleWordMessage(letter: .U, message: "is not in the word in any spot.")
 
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
                    Text("Log in or create a free NYT account to\nlink your stats")
                        .font(.custom(FontNames.normal, size: 15))
                        .lineSpacing(5)
                }
                .padding(.vertical, 8)
                
                
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
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
            HStack {
                SubmittedLetterView(letter: .W, letterSize: 25, status: .correct, index: 0, colorManager: colorManager)
                CurrentLetterView(letter: .O, letterSize: 25)
                CurrentLetterView(letter: .R, letterSize: 25)
                CurrentLetterView(letter: .D, letterSize: 25)
                CurrentLetterView(letter: .Y, letterSize: 25)
            }
            .frame(width: 200)
    }
}

private struct LightExampleWord: View {
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        HStack {
            CurrentLetterView(letter: .L, letterSize: 25)
            SubmittedLetterView(letter: .I, letterSize: 25, status: .included, index: 0, colorManager: colorManager)
            CurrentLetterView(letter: .G, letterSize: 25)
            CurrentLetterView(letter: .H, letterSize: 25)
            CurrentLetterView(letter: .T, letterSize: 25)
        }
        .frame(width: 200)
        
    }
}

private struct RogueExampleWord: View {
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        HStack {
            CurrentLetterView(letter: .R, letterSize: 25)
            CurrentLetterView(letter: .O, letterSize: 25)
            CurrentLetterView(letter: .G, letterSize: 25)
            SubmittedLetterView(letter: .U, letterSize: 25, status: .notIncluded, index: 0, colorManager: colorManager)
            CurrentLetterView(letter: .E, letterSize: 25)
        }
        .frame(width: 200)
        
    }
}
