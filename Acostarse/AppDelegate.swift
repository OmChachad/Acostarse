//
//  AppDelegate.swift
//  Acostarse
//
//  Created by Om Chachad on 6/5/25.
//

import Foundation

import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var onboardingWindow: NSWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Perform any setup after the application has launched
        print("Application did finish launching")
        
        let onboardingCompletedDate = UserDefaults.standard.value(forKey: "firstOnboardingCompletionDate")
        
        if onboardingCompletedDate == nil {
            presentOnboardingWindow()
        } else {
            print("Onboarding already completed")
        }
    }
    
    func presentOnboardingWindow() {
        onboardingWindow = NSWindow(
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
