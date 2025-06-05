//
//  ContentView.swift
//  snApp
//
//  Created by Om Chachad on 05/02/23.
//

import SwiftUI

struct GeneralSettings: View {
    @Environment(\.openURL) var openURL
    @State private var showIntroduction = false
    
    @AppStorage("strictMode") var strictMode: Bool = false
    
    var body: some View {
        Form {
            Section {
                Toggle("Strict Mode", isOn: $strictMode)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .help("Strict Mode disables the '5 more minutes' button and forces you to go to sleep when the alert appears.")
            } footer: {
                Text("Strict Mode disables the '5 more minutes' button and forces you to go to sleep when the alert appears.")
            }
            
            Section {
                HStack {
                    Text("Walkthrough")
                    Spacer()
                    Button("Start") {
                        showIntroduction.toggle()
                    }
                }
            }
            
        }
        .formStyle(.grouped)    }
}

