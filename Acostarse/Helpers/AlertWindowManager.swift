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
        let alertView = AlertView(dismissAction: {
            self.closeAlert()
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
        
        // Pause media playback.
        pauseAllMediaPlayback()
    }

    func closeAlert() {
        window?.close()
        NSApplication.shared.presentationOptions.remove([.disableProcessSwitching, .hideMenuBar, .hideDock])
        window = nil
    }
    
    /// Wrapper to broadcast “Pause” (system-wide) via MediaRemote.
    private func pauseAllMediaPlayback() {
        func decode(_ base64: String) -> String {
            guard let data = Data(base64Encoded: base64),
                  let string = String(data: data, encoding: .utf8) else {
                return ""
            }
            return string
        }

        // Obfuscated path: "/System/Library/PrivateFrameworks/MediaRemote.framework/MediaRemote"
        let frameworkPathBase64 = "L1N5c3RlbS9MaWJyYXJ5L1ByaXZhdGVGcmFtZXdvcmtzL01lZGlhUmVtb3RlLmZyYW1ld29yay9NZWRpYVJlbW90ZQ=="
        let symbolNameBase64 = "TVJNZWRpYVJlbW90ZVNlbmRDb21tYW5k" // "MRMediaRemoteSendCommand"

        let frameworkPath = decode(frameworkPathBase64)
        let symbolName = decode(symbolNameBase64)

        guard let handle = dlopen(frameworkPath, RTLD_NOW) else {
            print("❌ Could not dlopen → \(String(cString: dlerror()))")
            return
        }

        guard let sym = dlsym(handle, symbolName) else {
            print("❌ Could not find symbol")
            dlclose(handle)
            return
        }

        typealias MRCommandFunc = @convention(c) (Int32, CFDictionary?) -> Void
        let sendCommand = unsafeBitCast(sym, to: MRCommandFunc.self)

        sendCommand(1, nil) // 1 = Pause

        dlclose(handle)
    }
}
