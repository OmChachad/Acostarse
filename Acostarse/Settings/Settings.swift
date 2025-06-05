//
//  Settings.swift
//  Acostarse
//
//  Created by Om Chachad on 6/5/25.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @State private var current = 1
    
    var height: CGFloat {
        switch current {
        case 2:
            return 450
        case 3:
            return 600
        default:
            return 350
        }
    }
    
    var body: some View {
        TabView(selection: $current) {
            GeneralSettings()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(1)
            
            Roadmap()
                .tabItem {
                    Label("Roadmap", systemImage: "list.bullet")
                }
                .tag(2)
            
            TipJar()
                .environmentObject(Store())
                .tabItem {
                    Label("Tip Jar", systemImage: "heart.fill")
                }
                .tag(3)
            
            About()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
                .tag(4)
        }
        .frame(width: 400, height: height)
        .animation(.default, value: current)
        .onAppear {
            if let window = NSApplication.shared.windows.last {
                window.makeKeyAndOrderFront(nil)
                window.level = .normal
                NSApp.activate(ignoringOtherApps: true)
            }
        }
    }
}
