//
//  KeyView.swift
//  Wordle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct KeyView: View {
    var key: KeyboardButton
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    public var body: some View {
        Button {
            mainViewModel.handlePress(from: key)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(mainViewModel.keyboardManager.getButtonColor(for: key))
                
                AnyView(key.icon)
                    .foregroundStyle(.white)
                    .animation(.easeIn, value: key)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    KeyView(key: KeyboardButton.A)
       .environmentObject(MainViewModel())
}
