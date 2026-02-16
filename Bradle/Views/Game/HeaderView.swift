//
//  HeaderView.swift
//  Bradle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var bradleViewModel: BradleViewModel
    
    public var body: some View {
        HStack {
            Button(action: {
                bradleViewModel.sheet = .howToPlay
            }, label: {
                Image(systemName: "questionmark.circle")
            })
            Spacer()
            Text("BRADLE")
                .font(.headline)
            Spacer()
            Button(action: {
                bradleViewModel.sheet = .settings
            }, label: {
                Image(systemName: "gear")
            })
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    HeaderView()
        .background(.black)
        .environmentObject(BradleViewModel())
}
