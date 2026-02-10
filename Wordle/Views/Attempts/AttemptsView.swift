//
//  RowsFile.swift
//  Wordle
//
//  Created by Brady Carden on 1/24/26.
//

import SwiftUI

struct AttemptsView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                ForEach(mainViewModel.submittedAttempts, id: \.attempt.self) { attempt in
                    SubmittedAttemptView(submittedAttempt: attempt)
                        .frame(height: geometry.size.width * (1/5))
                    
                }
                if !mainViewModel.gameComplete {
                    AttemptView(attemptCase: .current)
                        .frame(height: geometry.size.width * (1/5))
                    
                    ForEach(0..<(5 - mainViewModel.submittedAttempts.count), id: \.self) { _ in
                        AttemptView(attemptCase: .empty)
                        .frame(height: geometry.size.width * (1/5))
                    }
                    
                } else {
                    ForEach(0..<(6 - mainViewModel.submittedAttempts.count), id: \.self) { _ in
                        AttemptView(attemptCase: .empty)
                        .frame(height: geometry.size.width * (1/5))                    }
                }
                
            }
            .padding(.horizontal, 3)
        }
    }
}

// MARK: - Functions

extension AttemptsView {
    func getSize(with geometry: GeometryProxy) -> CGFloat {
        let height = geometry.size.height * (1/6)
        let width = geometry.size.width * (1/6)
        
        return min(height, width)
    }
}

#Preview {
    AttemptsView()
        .environmentObject(MainViewModel())
}
