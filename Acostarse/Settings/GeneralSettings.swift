//
//  ContentView.swift
//  snApp
//
//  Created by Om Chachad on 05/02/23.
//

import SwiftUI

struct GeneralSettings: View {
    @NSApplicationDelegateAdaptor var appDelegate: AppDelegate
    @Environment(\.openURL) var openURL
    
    @AppStorage("strictMode") var strictMode: Bool = false
    
    var body: some View {
        Form {
            Section {
                Toggle("StrictMode.title", isOn: $strictMode)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .help("StrictMode.explanation")
            } footer: {
                Text("StrictMode.explanation")
                    .foregroundStyle(.secondary)
            }
            
            LogInToggle()
            
            Section {
                HStack {
                    Text("Walkthrough")
                    Spacer()
                    Button("Start") {
                        appDelegate.presentOnboardingWindow()
                    }
                }
            }
            
        }
        .formStyle(.grouped)    }
}

