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
                Button("Quit App", systemImage: "xmark") {
                    NSApp.terminate(nil)
                }
                .buttonStyle(MenuBarToolbarButtonStyle(direction: .trailing))
            }
        }
        .overlay(alignment: .topLeading) {
            if style == .menuBar {
                SettingsLink(label: {
                    Label("Settings", systemImage: "gear")
                })
                .buttonStyle(MenuBarToolbarButtonStyle(direction: .leading))
            }
        }
    }
}

struct MenuBarToolbarButtonStyle: ButtonStyle {
    @State private var isHovering = false
    var direction = Alignment.leading
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if direction == .trailing {
                configuration.label
                    .labelStyle(.titleOnly)
                    .transition(.blurReplace)
                    .opacity(isHovering ? 1 : 0)
            }
            
            configuration.label
                .bold()
                .labelStyle(.iconOnly)
            
            if direction == .leading {
                configuration.label
                    .labelStyle(.titleOnly)
                    .transition(.blurReplace)
                    .opacity(isHovering ? 1 : 0)
            }
        }
        .padding(5)
        .onHover {
            isHovering = $0
        }
        .opacity(configuration.isPressed ? 0.5 : 1)
        .background(.secondary.opacity(configuration.isPressed ? 0.2 : 0), in: .capsule)
        .animation(.easeInOut, value: isHovering)
        .animation(.spring, value: configuration.isPressed)
        .padding(10)
    }
}

#Preview {
    ContentView()
}
