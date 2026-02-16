//
//  KeyView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct KeyView: View {
    var key: KeyboardButton
    @State var color: Color = Color(UIColor.lightGray)
    
    @EnvironmentObject var bradleViewModel: BradleViewModel
    
    public var body: some View {
        Button {
            bradleViewModel.handlePress(from: key)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(color)
                
                AnyView(key.icon)
                    .foregroundStyle(.white)
                    .animation(.easeIn, value: key)
            }
        }
        .buttonStyle(.plain)
        .onChange(of: bradleViewModel.keyboardManager.getButtonColor(for: key)) { _, newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.color = newValue
            }
        }
    }
}

#Preview {
    KeyView(key: KeyboardButton.A)
       .environmentObject(BradleViewModel())
}
