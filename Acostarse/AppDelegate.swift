//
//  AppDelegate.swift
//  Acostar
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
            
            #if ONBOARDING_TESTING
            presentOnboardingWindow()
            #endif
        }
    }
}
