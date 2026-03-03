//
//  RoundedRectangleView.swift
//  Bradle
//
//  Created by Brady Carden on 3/2/26.
//
#if DEBUG

import SwiftUI

struct RoundedRectangleView: View {
    var body: some View {
        ScrollView {
            
            Spacer()
            
            Text("No Modifiers")
                .font(.caption)
            RoundedRectangle(cornerRadius: 5)
                .constrain()
            
            Text("Foreground Style - Red")
                .font(.caption)
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(.red)
                .constrain()
            
            Text("Fill - Red")
                .font(.caption)
            RoundedRectangle(cornerRadius: 5)
                .fill(.red)
                .constrain()
            
            Text("Tint - Red")
                .font(.caption)
            RoundedRectangle(cornerRadius: 5)
                .tint(.red)
                .constrain()
            
            Text("Stroke - Red")
                .font(.caption)
            RoundedRectangle(cornerRadius: 5)
                .stroke(.red)
                .constrain()
            
            Text("Border - Red")
                .font(.caption)
            RoundedRectangle(cornerRadius: 5)
                .border(.red)
                .constrain()
            
            Text("Fill - Red, No Border")
                .font(.caption)
            RoundedRectangle(cornerRadius: 0)
                .fill(.red)
                .constrain()
            
            Text("Fill - Red, Yes Border")
                .font(.caption)
            RoundedRectangle(cornerRadius: 0)
                .fill(.red)
                .border(.red)
                .constrain()
            
            Text("Blue Bordered under Red Not Bordered")
                .font(.caption)
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(.blue)
                    .border(.blue)
                    .constrain()
                
                RoundedRectangle(cornerRadius: 0)
                    .fill(.red)
                    .constrain()
            }
            
            Spacer()
        }
        .navigationTitle("Rounded Rectangle Color Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RoundedRectangleView()
}

#endif
