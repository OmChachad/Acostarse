//
//  Customization.swift
//  Acostar
//
//  Created by Om Chachad on 6/5/25.
//

import SwiftUI

struct Customization: View {
    @AppStorage("strictMode") var strictMode: Bool = false
    
    var body: some View {
        VStack {
            Text("Onboarding.StrictMode.title")
                .font(.largeTitle)
                .fontWidth(.expanded)
            
            Toggle("StrictMode.title", isOn: $strictMode)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            
            Text("StrictMode.explanation")
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    Customization()
}
