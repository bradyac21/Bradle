//
//  HeaderView.swift
//  Wordle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    public var body: some View {
        HStack {
            Image(systemName: "questionmark.circle")
            Spacer()
            Text("WORDLE")
                .font(.headline)
            Spacer()
            Image(systemName: "gear")
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    HeaderView()
        .background(.black)
        .environmentObject(MainViewModel())
}
