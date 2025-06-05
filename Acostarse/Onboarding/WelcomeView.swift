//
//  WelcomeView.swift
//  Acostarse
//
//  Created by Om Chachad on 6/5/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Image("Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .offset(y: -10)
            
            Text("Onboarding.Welcome")
                .font(.largeTitle)
                .fontWidth(.expanded)
                .bold()
        }
    }
}

#Preview {
    WelcomeView()
}
