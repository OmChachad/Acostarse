//
//  AcostarseApp.swift
//  Acostarse
//
//  Created by Om Chachad on 6/3/25.
//

import SwiftUI

@main
struct AcostarseApp: App {
    @StateObject private var alertManager = AlertWindowManager.shared
    @StateObject private var bedtimeMonitor: BedtimeMonitor

    init() {
        let alertManager = AlertWindowManager.shared
        _alertManager = StateObject(wrappedValue: alertManager)
        _bedtimeMonitor = StateObject(wrappedValue: BedtimeMonitor(alertManager: alertManager))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(alertManager)
                #if ALERT_SCREEN_TESTING
                .onAppear {
                    alertManager.showAlert()
                }
                #endif
        }
        
        MenuBarExtra("Acostarse", systemImage: "bed.double.fill") {
            ContentView(style: .menuBar)
                .frame(height: 300)
        }
        .menuBarExtraStyle(.window)
    }
}
