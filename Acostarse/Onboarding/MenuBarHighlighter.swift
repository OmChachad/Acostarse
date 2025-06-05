//
//  MenuBarHighlighter.swift
//  Acostarse
//
//  Created by Om Chachad on 6/5/25.
//

import SwiftUI

struct MenuBarHighlighter: View {
    var body: some View {
        VStack {
            Image("MenuBarScreenshot")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .shadow(radius: 5, y: 5)
            
            Spacer()
                .frame(height: 50)
            
            Text("Acostarse lives in your menu bar.")
                .font(.largeTitle)
                .fontWidth(.expanded)
            Text("Click on the menu bar icon to re-configure your bedtime settings anytime.")
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    MenuBarHighlighter()
}
