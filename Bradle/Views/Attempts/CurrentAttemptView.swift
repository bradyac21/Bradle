//
//  CurrentAttempt.swift
//  Bradle
//
//  Created by Brady Carden on 1/25/26.
//

import SwiftUI

struct CurrentAttemptView: View {
    @EnvironmentObject var bradleViewModel: BradleViewModel
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { index in
                CurrentLetterView(index: index)
                    .padding(.horizontal, 3)
            }
        }
        
    }
}

#Preview {
    CurrentAttemptView()
        .environmentObject(BradleViewModel())
}

