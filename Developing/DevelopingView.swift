//
//  DevelopingView.swift
//  Bradle
//
//  Created by Brady Carden on 3/2/26.
//
#if DEBUG

import SwiftUI

struct DevelopingView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(GameRunner.self) var gameRunner
    var body: some View {
        NavigationStack {
            Form {
                Section("Management") {
                    List {
                        NavigationLink("Manage Accounts", destination: BradleAccountsView(context: gameRunner.modelContext))
                    }
                }
                Section("Resources") {
                    List {
                        NavigationLink("Rounded Rectangle", destination: RoundedRectangleView())
                        NavigationLink("Bradle Colors", destination: BradleColorsView())
                        NavigationLink("Status Color", destination: StatusColorView())
                        NavigationLink("Status Borders", destination: StatusBorderView())
                        NavigationLink("Testing Tiles", destination: LetterVariants())
                    }
                }
            }
            .navigationTitle("Components and Colors")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    DevelopingView()
        .environment(ColorManager())
        .environment(GameRunner())
}

extension View {
    func constrain() -> some View {
        self
            .frame(width: 75, height: 75)
            .padding(.bottom, 10)
    }
}

#endif
