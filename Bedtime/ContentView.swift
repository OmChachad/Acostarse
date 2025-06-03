//
//  ContentView.swift
//  Bedtime
//
//  Created by Om Chachad on 6/3/25.
//

import SwiftUI

class AlertWindowManager: ObservableObject {
    private var window: NSWindow?

    func showAlert() {
        if window != nil { return }
        let alertView = AlertView(dismissAction: { [weak self] in
            self?.closeAlert()
        })
        let hosting = NSHostingController(rootView: alertView)
        window = NSWindow(contentViewController: hosting)
        window?.styleMask = [.borderless]
        window?.level = .screenSaver
        window?.isOpaque = true
        window?.backgroundColor = NSColor.black.withAlphaComponent(0.95)
        window?.ignoresMouseEvents = false
        window?.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .stationary, .ignoresCycle]
        window?.setFrame(NSScreen.main?.frame ?? .zero, display: true)
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    func closeAlert() {
        window?.close()
        window = nil
    }
}

struct ContentView: View {
    @AppStorage("bedtime") var bedtime: Date = Calendar.current.date(bySettingHour: 23, minute: 0, second: 0, of: Date()) ?? Date()
    @StateObject private var alertManager = AlertWindowManager()

    var body: some View {
        VStack {
            Text("What's your bedtime?")
                .font(.largeTitle)
                .fontWidth(.expanded)
            DatePicker("Choose a time:", selection: $bedtime, displayedComponents: .hourAndMinute)
                .padding(5)
                .background(.thickMaterial, in: .rect(cornerRadius: 10, style: .continuous))
        }
        .padding()
        .onAppear(perform: presentAlert)
    }

    func presentAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alertManager.showAlert()
        }
    }
}

#Preview {
    ContentView()
}
