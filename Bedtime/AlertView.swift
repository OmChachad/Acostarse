//
//  AlertView.swift
//  Bedtime
//
//  Created by Om Chachad on 6/3/25.
//

import SwiftUI
import IOKit.pwr_mgt

struct AlertView: View {
    var dismissAction: (() -> Void)?
    
    @State private var isVisible = false
    @State private var isGoingtoSleep = false

    var body: some View {
        ZStack {
            if isVisible {
                VisualEffectView()
                    .opacity(isVisible ? 0.95 : 0)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    if isVisible {
                        Image(systemName: "bed.double.fill")
                            .font(.system(size: 100))
                            .padding(.bottom, 20)
                        
                        Text("It's bedtime.")
                            .font(.system(size: 50))
                            .bold()
                            .fontWidth(.expanded)
                        
                        Text("Turn off your Mac and head to sleep.")
                            .font(.largeTitle)
                        
                        Button("Go to sleep") {
                            startScreenSleep()
                        }
                        .buttonStyle(AlertButton())
                        
                        Spacer()
                        
                        Button("I need 5 more minutes.") {
                            dismissAction?()
                        }
                        .buttonStyle(.borderless)
                    }
                }
                .padding()
                .transition(.blurReplace)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            Color.black
                .opacity(isGoingtoSleep ? 1 : 0)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
        .onAppear {
            NSSound(named: NSSound.Name("Blow"))?.play()
            
            withAnimation(.easeOut(duration: 1.5)) {
                isVisible = true
            }
        }
    }
    
    func startScreenSleep() {
        withAnimation {
            isGoingtoSleep = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let port = IOPMFindPowerManagement(mach_port_t(MACH_PORT_NULL))
                IOPMSleepSystem(port)
                IOServiceClose(port)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isGoingtoSleep = false
                dismissAction?()
            }
        }
        
    }
}

#Preview {
    AlertView()
}
