//
//  UserDefaultsView.swift
//  Bradle
//
//  Created by Brady Carden on 3/3/26.
//

import SwiftUI

struct UserDefaultsView: View {
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = true
    @AppStorage("highContrast") var highContrastEnabled: Bool = false
    
    var body: some View {
        ScrollView {
            Toggle("Dark Mode Enabled", isOn: $darkModeEnabled)
            Toggle("High Constrast Enabled", isOn: $highContrastEnabled)
        }
        .padding()
        .navigationTitle("User Defaults")
        .navigationBarTitleDisplayMode(.inline)
    }
}
