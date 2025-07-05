//
//  AcostarApp.swift
//  Acostar
//
//  Created by Om Chachad on 6/3/25.
//

import SwiftUI

@main
struct AcostarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var alertManager = AlertWindowManager.shared
    @StateObject private var bedtimeMonitor: BedtimeMonitor = BedtimeMonitor()
    @StateObject var storeKit = Store.shared

    var body: some Scene {
        #if ALERT_SCREEN_TESTING
        WindowGroup {
            ContentView()
                .environmentObject(alertManager)
                .onAppear {
                    alertManager.showAlert()
                }
        }
        #endif
        
        MenuBarExtra("Acostar", systemImage: "bed.double.fill") {
            ContentView(style: .menuBar)
                .frame(height: 300)
        }
        .menuBarExtraStyle(.window)
        
        Settings {
            SettingsView()
                .environmentObject(storeKit)
        }
        .defaultPosition(.center)
    }
}
