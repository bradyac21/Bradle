//
//  KeyView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct KeyView: View {
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    var key: KeyboardButton
    @State var status: SubmittedStatus? = nil
    
    @Environment(ColorManager.self) var colorManager
    @Environment(GameRunner.self) var gameRunner

    public var body: some View {
        Button {
            gameRunner.handlePress(from: key)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(colorManager.submittedStatusColors[safeKey: status])
                
                key.icon
                    .foregroundStyle(colorManager[safeKey: status])
                    .animation(.easeIn, value: key)
            }
        }
        .buttonStyle(.plain)
        .onChange(of: gameRunner.keyboardManager.buttonStatus[safeKey: key]) { _, newStatus in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.status = newStatus
            }
        }
    }
}

#Preview {
    KeyView(key: KeyboardButton.A)
       .environment(GameRunner())
       .environment(ColorManager())
}
