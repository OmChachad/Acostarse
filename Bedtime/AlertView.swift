//
//  AlertView.swift
//  Bedtime
//
//  Created by Om Chachad on 6/3/25.
//

import SwiftUI

struct AlertView: View {
    var dismissAction: (() -> Void)?
    @State private var isVisible = false

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
                        
                        Button("Go to sleep") {}
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
        .onAppear {
            NSSound(named: NSSound.Name("Blow"))?.play()
            
            withAnimation(.easeOut(duration: 1.5)) {
                isVisible = true
            }
        }
    }
}

#Preview {
    AlertView()
}
