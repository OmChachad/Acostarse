//
//  AlertWindowManager.swift
//  Bedtime
//
//  Created by Om Chachad on 6/3/25.
//

import Foundation
import AppKit
import SwiftUI

class AlertWindowManager: ObservableObject {
    static let shared = AlertWindowManager()
    private init() {}
    
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
        window?.backgroundColor = NSColor.black.withAlphaComponent(0)
        window?.ignoresMouseEvents = false
        window?.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .stationary, .ignoresCycle]
        NSApplication.shared.presentationOptions.insert([.disableProcessSwitching, .hideMenuBar, .hideDock])
        window?.setFrame(NSScreen.main?.frame ?? .zero, display: true)
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    func closeAlert() {
        window?.close()
        NSApplication.shared.presentationOptions.remove([.disableProcessSwitching, .hideMenuBar, .hideDock])
        window = nil
    }
}
