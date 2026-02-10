//
//  ContentView.swift
//  Wordle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct MainView: View {
    @StateObject var mainViewModel = MainViewModel()
    
    var body: some View {
        GeometryReader { geometry in

                VStack(alignment: .center, spacing: 0) {
                    HeaderView()
                        .frame(width: geometry.size.width * 0.95, height: geometry.size.width * 0.15)
                    
                    Divider()
                    Spacer()
                    Text(mainViewModel.alertMessage)
                        .foregroundStyle(.white)
                    Spacer()
                    
                    AttemptsView()
                        .frame(height: geometry.size.height * 0.5)
                        .frame(width: geometry.size.width * 0.75)
                    
                    Spacer()
                    KeyboardView()
                        .frame(height: geometry.size.height * 0.25)
                }

        }
        .background(.black)
        .environmentObject(mainViewModel)
    }
}

#Preview {
    MainView()
}
