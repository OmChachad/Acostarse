//
//  ContentView.swift
//  Bedtime
//
//  Created by Om Chachad on 6/3/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("strictMode") var strictMode: Bool = false
    
    enum Style {
        case mainApp, menuBar
    }
    
    var style: Style = .mainApp

    var body: some View {
        VStack {
            Spacer()
            
            BedtimeConfigurationView()
            
            Spacer()
            
            Toggle("StrictMode.title", isOn: $strictMode)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            
            Text("StrictMode.explanationCompact")
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
        .padding()
        .multilineTextAlignment(.center)
        .overlay(alignment: .topTrailing) {
            if style == .menuBar {
                Button("Close", systemImage: "xmark") {
                    NSApp.terminate(nil)
                }
                .bold()
                .buttonStyle(.borderless)
                .labelStyle(.iconOnly)
                .padding()
            }
        }
        .overlay(alignment: .topLeading) {
            if style == .menuBar {
                SettingsLink(label: {
                    Label("Settings", systemImage: "gear")
                })
                .bold()
                .buttonStyle(.borderless)
                .labelStyle(.iconOnly)
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
