//
//  BedtimeManager.swift
//  Bedtime
//
//  Created by Om Chachad on 6/3/25.
//

import SwiftUI
import Combine

class BedtimeMonitor: ObservableObject {
    @AppStorage("bedtime") var bedtime: Date = Calendar.current.date(bySettingHour: 23, minute: 0, second: 0, of: Date()) ?? Date()
    private var timer: Timer?
    private let alertManager: AlertWindowManager

    init(alertManager: AlertWindowManager) {
        self.alertManager = alertManager
        startTimer()
    }

    private func startTimer() {
        let currentTimeSecondComponent = Calendar.current.dateComponents([.second], from: Date()).second ?? 0
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(60 - currentTimeSecondComponent)) {
            self.checkBedtime()
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
                self?.checkBedtime()
            }
        }
    }

    private func checkBedtime() {
        let now = Calendar.current.dateComponents([.hour, .minute], from: Date())
        let bedtimeComponents = Calendar.current.dateComponents([.hour, .minute], from: bedtime)
        if now.hour == bedtimeComponents.hour && now.minute == bedtimeComponents.minute {
            alertManager.showAlert()
        }
    }

    deinit {
        timer?.invalidate()
    }
}
