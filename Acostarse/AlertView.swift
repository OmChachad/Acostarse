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
    
    @AppStorage("strictMode") var strictMode: Bool = false

    var body: some View {
        ZStack {
            if isVisible {
                VisualEffectView()
                    .opacity(isVisible ? 1 : 0)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    if isVisible {
                        Image(systemName: "bed.double.fill")
                            .font(.system(size: 100))
                            .padding(.bottom, 20)
                        
                        Text("FullScreenAlert.title")
                            .font(.system(size: 50))
                            .bold()
                            .fontWidth(.expanded)
                        
                        Text("FullScreenAlert.subtitle")
                            .font(.largeTitle)
                        
                        Button("FullScreenAlert.goToSleepButton") {
                            startScreenSleep()
                        }
                        .buttonStyle(AlertButton())
                        
                        Spacer()
                        
                        if !strictMode {
                            Button("FullScreenAlert.delaySleep") {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    isVisible = false
                                }
                                
                                BedtimeMonitor().scheduleAlertIn(minutes: 5)
                                
                                NSApplication.shared.presentationOptions.remove([.disableProcessSwitching, .hideMenuBar, .hideDock])
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    dismissAction?()
                                }
                            }
                            .buttonStyle(.borderless)
                        }
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
