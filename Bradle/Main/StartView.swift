//
//  StartView.swift
//  Bradle
//
//  Created by Brady Carden on 2/9/26.
//

import SwiftUI

struct StartView: View {
    @Environment(GameRunner.self) var gameRunner
    
    var body: some View {
        VStack {
            #if DEBUG
            Button("Debug Options", systemImage: "info.circle"){
                AppState.shared.fullScreenCover = .testing
            }
            .labelStyle(.iconOnly)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .foregroundStyle(.blue)
            #endif
            
            Spacer()
            Image("Bradle-Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            Text("Bradle")
                .font(.custom(FontNames.mainTitle, size: 35))
                .padding(.bottom, 5)
                        
            Text(messageString)
                .lineSpacing(0)
                .multilineTextAlignment(.center)
                .font(.custom(FontNames.mediumFancy, size: 22.5))
                .padding(.bottom)
            
            BradleButton("Play", textColor: BradleColors.light, fillColor: .black) {
                AppState.shared.location = .game
            }
            
            if !AccountStore.isLoggedIn {
                BradleButton("Log in", fillColor: BradleColors.light) {
                    AppState.shared.sheet = .login(.login)
                }
            }
            
            BradleButton("Subscribe", fillColor: BradleColors.light) {
                print("Subscribe tapped")
            }
            
            Spacer()
            
            Text(Date().formatted(date: .long, time: .omitted))
            Text("Created by Brady Carden")
                .fontWeight(.light)
                .font(.system(size: 15))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(BradleColors.light)
        .foregroundStyle(.black)
    }
}

extension StartView {
    var messageString: AttributedString {
        if let account = AccountStore.shared.account {
            if account.currentStreak > 0 {
                var attributed = AttributedString("Go ahead, add another day to\nyour \(account.currentStreak) day streak.")
                for (range, char) in zip(attributed.characters.indices, attributed.characters) {
                    if char == " " {
                        let attrRange = range..<attributed.characters.index(after: range)
                        attributed[attrRange].kern = -3
                    }
                }
                if let range = attributed.range(of: "\(account.currentStreak) day") {
                    attributed[range].font = .custom("Hanuman-ExtraBold", size: 22)
                }
                return attributed
            }
        }
        return "Get 6 chances to guess a\n 5-letter word."
    }
}

#Preview {
    StartView()
        .environment(GameRunner())
}

struct BradleButton<Label: View>: View {
    var label: Label
    var textColor: Color
    var fillColor: Color
    var size: BradleButtonSize
    var action: () -> Void
    
    init(textColor: Color = .black, fillColor: Color, size: BradleButtonSize = .small, action: @escaping () -> Void, @ViewBuilder label: () -> Label) {
        self.label = label()
        self.textColor = textColor
        self.fillColor = fillColor
        self.size = size
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            label
        }
        .buttonStyle(BradleButtonStyle(textColor: textColor, fillColor: fillColor, size: size))
    }
}

public enum BradleButtonSize {
    case small, large
    
    var width: CGFloat {
        switch self {
        case .small: 150
        case .large: 300
        }
    }
}

extension BradleButton where Label == Text {
    init(_ label: String, textColor: Color = .black, fillColor: Color, size: BradleButtonSize = .small, action: @escaping () -> Void ) {
        self.init(textColor: textColor, fillColor: fillColor, size: size, action: action) {
            Text(label)
        }
    }
}

struct BradleButtonStyle: ButtonStyle {
    let textColor: Color
    let fillColor: Color
    let size: BradleButtonSize
    
    init(textColor: Color = .black, fillColor: Color, size: BradleButtonSize = .small) {
        self.textColor = textColor
        self.fillColor = fillColor
        self.size = size
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(textColor)
            .frame(width: size.width, height: 20)
            .padding(.vertical, 12.5)
            .background {
                Capsule()
                    .stroke(BradleColors.dark, lineWidth: 2)
                    .fill(fillColor)
            }
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}

