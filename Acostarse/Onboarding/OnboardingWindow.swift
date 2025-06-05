//
//  OnboardingWindow.swift
//  Acostarse
//
//  Created by Om Chachad on 6/5/25.
//

import Foundation
import AppKit
import SwiftUI

class OnboardingWindow: NSWindow {
    // This is necessary, otherwise, the user will not be able to enter use their keyboard to interact with the app.
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
}

extension AppDelegate {
    func presentOnboardingWindow() {
        onboardingWindow = OnboardingWindow(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 620),
            styleMask: [.titled],
            backing: .buffered,
            defer: false
        )

        // Customize window appearance
        onboardingWindow?.titleVisibility = .hidden
        onboardingWindow?.styleMask.remove(.titled)
        onboardingWindow?.backgroundColor = .clear
        onboardingWindow?.isOpaque = false
        onboardingWindow?.isMovableByWindowBackground = true
        onboardingWindow?.hasShadow = false // Use custom shadow inside OnboardingController if needed
        onboardingWindow?.center()
        // Embed SwiftUI root view
        let rootView = OnboardingController {
            NSApp.setActivationPolicy(.prohibited)
            self.onboardingWindow?.close()
        }

        let hostingView = NSHostingView(rootView: rootView)
        hostingView.translatesAutoresizingMaskIntoConstraints = false

        if let contentView = onboardingWindow?.contentView {
            contentView.addSubview(hostingView)

            NSLayoutConstraint.activate([
                hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }

        // Show window
        onboardingWindow?.center()
        onboardingWindow?.makeKeyAndOrderFront(nil)
        onboardingWindow?.level = .floating

        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
        NSApp.keyWindow?.orderFrontRegardless()
    }
}
