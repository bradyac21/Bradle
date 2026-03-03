//
//  LetterVariants.swift
//  Bradle
//
//  Created by Brady Carden on 3/2/26.
//

import SwiftUI

@Observable
class LetterVariantsVM {
    var texts: [String] = ["R", "O", "G", "U", "E"]
    var statuses: [Status2] = [.correct, .included, .notIncluded, .notIncluded, .included]
    var doneAnimating: [Bool] = Array(repeating: false, count: 5)
    
    var submitted: Bool = false
    var correctGuess: Bool = false
    
    func reset() {
        texts = ["R", "O", "G", "U", "E"]
        statuses = [.correct, .included, .notIncluded, .notIncluded, .included]
        doneAnimating = Array(repeating: false, count: 5)
        
        submitted = false
        correctGuess = false
    }
}


struct LetterVariants: View {
    @State var model = LetterVariantsVM()
    
    let statusChoices: [Status2] = [.correct, .included, .notIncluded]
            
    var body: some View {
        ZStack {
            BradleColors.darkModeBackground.ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    TextField("Letter", text: $model.texts[0])
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                        .onChange(of: model.texts[0]) { _, newValue in
                            model.texts[0] = String(newValue.prefix(1)).capitalized
                        }
                    
                    TextField("Letter", text: $model.texts[1])
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                        .onChange(of: model.texts[1]) { _, newValue in
                            model.texts[1] = String(newValue.prefix(1)).capitalized
                        }
                    
                    TextField("Letter", text: $model.texts[2])
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                        .onChange(of: model.texts[2]) { _, newValue in
                            model.texts[2] = String(newValue.prefix(1)).capitalized
                        }
                    
                    TextField("Letter", text: $model.texts[3])
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                        .onChange(of: model.texts[3]) { _, newValue in
                            model.texts[3] = String(newValue.prefix(1)).capitalized
                        }
                    
                    TextField("Letter", text: $model.texts[4])
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                        .onChange(of: model.texts[4]) { _, newValue in
                            model.texts[4] = String(newValue.prefix(1)).capitalized
                        }
                    
                }
                
                HStack {
                    Picker("Status", selection: $model.statuses[0]) {
                        ForEach(statusChoices, id: \.self) { status in
                            Text(status.abbreviated)
                        }
                    }
                    
                    Picker("Status", selection: $model.statuses[1]) {
                        ForEach(statusChoices, id: \.self) { status in
                            Text(status.abbreviated)
                        }
                    }
                    
                    Picker("Status", selection: $model.statuses[2]) {
                        ForEach(statusChoices, id: \.self) { status in
                            Text(status.abbreviated)
                        }
                    }
                    
                    Picker("Status", selection: $model.statuses[3]) {
                        ForEach(statusChoices, id: \.self) { status in
                            Text(status.abbreviated)
                        }
                    }
                    
                    Picker("Status", selection: $model.statuses[4]) {
                        ForEach(statusChoices, id: \.self) { status in
                            Text(status.abbreviated)
                        }
                    }
                }
                
                HStack(spacing: 0) {
                    ForEach(0..<5, id: \.self) { index in
                        TileWrapper(
                            letter: model.texts[index],
                            status: model.statuses[index],
                            submitted: model.submitted,
                            index: index,
                            correctGuess: model.correctGuess,
                            doneAnimating: $model.doneAnimating[index]
                        )
                    }
                }
                
                if model.submitted {
                    VStack {
                        Button("Float") {
                            model.correctGuess.toggle()
                        }
                        
                        Button("Reset", role: .destructive) {
                            model.reset()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                } else {
                    Button("Submit") {
                        if !model.texts.contains("") {
                            model.submitted = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    LetterVariants()
}

struct TileWrapper: View {
    let letter: String
    let status: Status2
    var submitted: Bool
    let index: Int
    let correctGuess: Bool
    
    @Binding var doneAnimating: Bool
    
    var body: some View {
        if letter == "" {
            EmptyTile()
        } else {
            if doneAnimating {
                StatusTile(
                    index: index, letter: letter,
                    status: status,
                    floatTrigger: correctGuess
                )
            } else {
                FilledTile(
                    letter: letter,
                    doneAnimating: $doneAnimating,
                    flipTrigger: submitted,
                    index: index
                )
            }
        }
    }
}

struct EmptyTile: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(.clear)
            .border(BradleColors.darkModeEmptyBorder)
            .aspectRatio(1.0, contentMode: .fit)
            .padding(.horizontal, 3)
            .frame(height: 200, alignment: .top)
    }
}

struct FilledTile: View {
    let letter: Letter
    let flipTrigger: Bool
    let flipDelay: CGFloat
    
    @State var shouldPop: Bool = false
    @Binding var doneAnimating: Bool
    @State var shouldFlip: Bool = false
    
    init(letter: String, doneAnimating: Binding<Bool> = .constant(false), flipTrigger: Bool = false, index: Int = -1) {
        guard let convertedLetter = Letter(rawValue: letter) else {
            fatalError("Could not convert letter = \(letter) to Letter enum.")
        }
        
        self.letter = convertedLetter
        self._doneAnimating = doneAnimating
        self.flipTrigger = flipTrigger
        self.flipDelay = CGFloat(index) * 0.4
    }
    
    init(letter: Letter, doneAnimating: Binding<Bool> = .constant(false), flipTrigger: Bool = false, index: Int = -1) {
        self.letter = letter
        self._doneAnimating = doneAnimating
        self.flipTrigger = flipTrigger
        self.flipDelay = CGFloat(index) * 0.4
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(.clear)
                .border(BradleColors.darkModeFilledBorder)
                .aspectRatio(1.0, contentMode: .fit)
            
            Text(letter.rawValue)
                .font(.custom("NYTFranklin-Bold", size: 30))
                .minimumScaleFactor(0.5)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 3)
        .frame(height: 200)

        // Pop animation triggered with non-empty letter change
        .popAnimation(trigger: shouldPop)
        
        // Flip animation to hide FilledTile
        .scaleEffect(y: shouldFlip ? 0 : 1)
        .onChange(of: flipTrigger) { _, _ in
            withAnimation(.linear(duration: 0.2).delay(flipDelay)) {
                shouldFlip.toggle()
            } completion: {
                doneAnimating = true
            }
        }
        
        // Trigger pop on appear
        .onAppear {
            shouldPop.toggle()
        }
    }
}



struct StatusTile: View {
    let letter: Letter
    let status: Status2
    let floatTrigger: Bool

    let flipDelay: CGFloat
    let floatDelay: CGFloat
    
    @State var shouldFlip: Bool = false
    
    
    init(index: Int, letter: String, status: Status2, floatTrigger: Bool) {
        guard let convertedLetter = Letter(rawValue: letter) else {
            fatalError("Could not convert letter = \(letter) to Letter enum.")
        }
        
        self.letter = convertedLetter
        self.status = status
        self.floatTrigger = floatTrigger

        self.flipDelay = CGFloat(index) * 0.4
        self.floatDelay = CGFloat(index) * 0.1
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(status.color)
                .aspectRatio(1.0, contentMode: .fit)
            
            Text(letter.rawValue)
                .font(.custom("NYTFranklin-Bold", size: 30))
                .minimumScaleFactor(0.5)
                .foregroundStyle(.white)
                .padding(.bottom, 5)
        }
        .padding(.horizontal, 3)
        .frame(height: 200)
        
        // Finish flip animation on appear to show status
        .scaleEffect(y: shouldFlip ? 1 : 0)
        .onAppear {
            withAnimation(.linear(duration: 0.2)) {
                shouldFlip.toggle()
            }
        }
        
        // Float animation for success
        .floatAnimation(using: floatTrigger, with: floatDelay)
    }
}

extension View {
    func floatAnimation(using trigger: Bool, with delay: CGFloat) -> some View {
        phaseAnimator(FloatAnimation.phases, trigger: trigger) { content, phase in
            content.offset(y: phase.yOffset)
        } animation: { phase in
            .easeOut(duration: phase.duration).delay(phase == .peak ? delay : 0)
        }
    }
}

extension Status2 {
    var color: Color {
        switch self {
        case .initial:
            Color.red
        case .notIncluded:
            BradleColors.darkModeNotIncluded
        case .included:
            BradleColors.yellow
        case .correct:
            BradleColors.green
        }
    }
    
    var text: String {
        switch self {
        case .initial:
            "Initial"
        case .notIncluded:
            "Not Included"
        case .included:
            "Included"
        case .correct:
            "Correct"
        }
    }
    
    var abbreviated: String {
        switch self {
            
        case .initial:
            "init."
        case .notIncluded:
            "not Inc."
        case .included:
            "inc."
        case .correct:
            "cor."
        }
    }
}
