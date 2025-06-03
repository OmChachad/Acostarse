//
//  AcostarseApp.swift
//  Acostarse
//
//  Created by Om Chachad on 6/3/25.
//

import SwiftUI

@main
struct BedtimeApp: App {
    @StateObject private var alertManager = AlertWindowManager()
    @StateObject private var bedtimeMonitor: BedtimeMonitor

    init() {
        let alertManager = AlertWindowManager()
        _alertManager = StateObject(wrappedValue: alertManager)
        _bedtimeMonitor = StateObject(wrappedValue: BedtimeMonitor(alertManager: alertManager))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(alertManager)
        }
        
        MenuBarExtra("Acostarse", systemImage: "bed.double.fill") {
            ContentView(style: .menuBar)
                .frame(height: 300)
        }
        .menuBarExtraStyle(.window)
    }
}
