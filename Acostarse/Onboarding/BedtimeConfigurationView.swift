//
//  BedtimeConfigurationView.swift
//  Acostar
//
//  Created by Om Chachad on 6/5/25.
//

import SwiftUI

struct BedtimeConfigurationView: View {
    @AppStorage("bedtime") var bedtime: Date = Calendar.current.date(bySettingHour: 23, minute: 0, second: 0, of: Date()) ?? Date()
    @AppStorage("strictMode") var strictMode: Bool = false
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack {
            Text("What's your bedtime?")
                .font(.largeTitle)
                .fontWidth(.expanded)
            
            HStack {
                DatePicker("Choose a time:", selection: $bedtime, displayedComponents: .hourAndMinute)
                    .padding(5)
                    .datePickerStyle(.field)
                    .scaleEffect(1.5)
                    .labelsHidden()
                    .offset(y: 2)
                    .frame(width: 95, height: 30)
                    .background(.thickMaterial)
                    .background(.white.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 10, style: .continuous))
                    .focused($isFocused)
                    .transition(.blurReplace)
                    .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
                
                if isFocused {
                    Button("Done", systemImage: "checkmark") {
                        isFocused = false
                    }
                    .labelStyle(.iconOnly)
                    .buttonStyle(.borderless)
                    .bold()
                    .foregroundStyle(Color.accentColor)
                    .font(.system(size: 15, weight: .bold))
                    .frame(width: 30, height: 30)
                    .background(.thickMaterial)
                    .background(.white.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 10, style: .continuous))
                    .opacity(isFocused ? 1 : 0)
                    .transition(.blurReplace)
                }
            }
            .animation(.spring, value: isFocused)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    BedtimeConfigurationView()
}
