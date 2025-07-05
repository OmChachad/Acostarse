//
//  MenuBarHighlighter.swift
//  Acostar
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
            
            Text("Onboarding.MenuBarHighlighter.title")
                .font(.largeTitle)
                .fontWidth(.expanded)
            Text("Onboarding.MenuBarHighlighter.explanation")
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    MenuBarHighlighter()
}
