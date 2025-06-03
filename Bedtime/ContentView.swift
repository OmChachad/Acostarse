//
//  ContentView.swift
//  Bedtime
//
//  Created by Om Chachad on 6/3/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("bedtime") var bedtime: Date = Calendar.current.date(bySettingHour: 23, minute: 0, second: 0, of: Date()) ?? Date()
    @StateObject private var alertManager = AlertWindowManager()

    var body: some View {
        VStack {
            Text("What's your bedtime?")
                .font(.largeTitle)
                .fontWidth(.expanded)
            DatePicker("Choose a time:", selection: $bedtime, displayedComponents: .hourAndMinute)
                .padding(5)
                .background(.thickMaterial, in: .rect(cornerRadius: 10, style: .continuous))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
