//
//  Customization.swift
//  Acostarse
//
//  Created by Om Chachad on 6/5/25.
//

import SwiftUI

struct Customization: View {
    @AppStorage("strictMode") var strictMode: Bool = false
    
    var body: some View {
        VStack {
            Text("Prone to Proctrastination?\nEnable Strict Mode.")
                .font(.largeTitle)
                .fontWidth(.expanded)
            
            Toggle("Strict Mode", isOn: $strictMode)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            
            Text("Strict Mode will prevent you from delaying bedtime and will force you to put your Mac to sleep.")
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    Customization()
}
