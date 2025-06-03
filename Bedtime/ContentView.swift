//
//  ContentView.swift
//  Bedtime
//
//  Created by Om Chachad on 6/3/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("bedtime") var bedtime: Date = Calendar.current.date(bySettingHour: 23, minute: 0, second: 0, of: Date()) ?? Date()
    @AppStorage("strictMode") var strictMode: Bool = false
    
    @StateObject private var alertManager = AlertWindowManager()

    var body: some View {
        VStack {
            Spacer()
            
            Text("What's your bedtime?")
                .font(.largeTitle)
                .fontWidth(.expanded)
            
            DatePicker("Choose a time:", selection: $bedtime, displayedComponents: .hourAndMinute)
                .padding(5)
                .background(.thickMaterial)
                .background(.white.opacity(0.2))
                .clipShape(.rect(cornerRadius: 10, style: .continuous))
            
            Spacer()
            
            Toggle("Strict Mode", isOn: $strictMode)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            
            Text("Strict Mode will prevent you from delaying bedtime.")
                .foregroundStyle(.secondary)
        }
        .padding()
        .multilineTextAlignment(.center)
    }
}

#Preview {
    ContentView()
}
