//
//  TestingView.swift
//  Bradle
//
//  Created by Brady Carden on 2/26/26.
//

import SwiftUI

struct PreviewView: View {
    var body: some View {
        NavigationStack {
            Form {
                List {
                    NavigationLink("Rounded Rectangle", destination: RoundedRectangleView())
                }
            }
        }
    }
}

struct RoundedRectangleView: View {
    var body: some View {
        VStack {
            Text("Rounded Rectangle Color Settings")
            
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
            
            Spacer()
        }
    }
}

extension View {
    func constrain() -> some View {
        self
            .frame(width: 75, height: 75)
            .padding(.bottom, 10)
    }
}

#Preview {
    RoundedRectangleView()
}
