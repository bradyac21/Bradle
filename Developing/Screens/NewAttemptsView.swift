//
//  NewAttemptsView.swift
//  Bradle
//
//  Created by Brady Carden on 3/3/26.
//

import SwiftUI

@Observable
class AttemptsViewModel {
    var submittedAttempts: [SubmittedAttempt]
    var currentAttempt: CurrentAttempt
    var remainingAttempts: Int
    
    init() {
        submittedAttempts = []
        currentAttempt = CurrentAttempt()
        remainingAttempts = 5
    }
}

struct NewAttemptsView: View {
    
    @State var model = AttemptsViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            GeometryReader { geo in
                VStack {
                    ForEach(model.submittedAttempts, id: \.self) { submittedAttempt in
                        EmptyView()
                    }
                    
                    CurrentAttemptTiles(currentAttempt: model.currentAttempt)
                    
                    ForEach(0..<model.remainingAttempts, id: \.self) { _ in
                        EmptyTiles()
                    }
                }
                .containerRelativeFrame(.vertical) { height, _ in
                    height * 0.5
                }
                .frame(height: geo.size.width * (6/5))
            }
            
            
            Spacer()
        }
    }
}

#Preview {
    ZStack {
        BradleColors.darkModeBackground.ignoresSafeArea()
        NewAttemptsView()
    }
}

struct EmptyTiles: View {
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { _ in
                EmptyTile()
                    .padding(.horizontal, 3)
            }
        }
    }
}

struct SubmittedAttemptTiles: View {
    let submittedAttempt: SubmittedAttempt
    var body: some View {
        EmptyView()
    }
}

struct SubmittedAttemptTile: View {
    var body: some View {
        EmptyView()
    }
}

struct CurrentAttemptTiles: View {
    let currentAttempt: CurrentAttempt
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(currentAttempt.letters, id: \.self) { letter in
                CurrentAttemptTile(letter: letter)
            }
        }
    }
}

struct CurrentAttemptTile: View {
    let letter: Letter
    let index: Int = -1
    
    var body: some View {
        if letter != .empty {
            FilledTile(letter: letter)
        } else {
            EmptyTile()
        }
    }
}

struct EmptyTile2: View {
    
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(.clear)
            .border(colorManager.currentStatusBorderColors[safeKey: .empty])
            .aspectRatio(1.0, contentMode: .fit)
            .padding(.horizontal, 3)
    }
}

struct FilledTile2: View {
    let letter: Letter
    let popEnabled: Bool = true
    @State var popTrigger: Bool = false
    
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(.clear)
                .border(colorManager.currentStatusBorderColors[safeKey: .filled])
                .aspectRatio(1.0, contentMode: .fit)
            
            Text(letter.rawValue)
                .font(.custom(FontNames.bold, size: 30))
                .minimumScaleFactor(0.5)
                .foregroundStyle(colorManager.primary)
        }
        .popAnimation(trigger: popTrigger)
        .padding(.horizontal, 3)
        .onAppear {
            if popEnabled {
                popTrigger.toggle()
            }
        }
    }
}

struct StatusTile2: View {
    let letter: Letter
    let status: SubmittedStatus
    
    @Environment(ColorManager.self) var colorManager
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .fill(status.color)
                .aspectRatio(1.0, contentMode: .fit)
            
            Text(letter.rawValue)
                .font(.custom(FontNames.bold, size: 30))
                .minimumScaleFactor(0.5)
            
            // Needs a different thing because of light mode
                .foregroundStyle(colorManager.primary)
                .padding(.bottom, 5)
        }
        .padding(.horizontal, 3)
    }
}

