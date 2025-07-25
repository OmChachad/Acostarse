//
//  About.swift
//  snApp
//
//  Created by Om Chachad on 28/05/23.
//

import SwiftUI

struct About: View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Image("Om")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                    
                    VStack(alignment: .leading) {
                        Text("About.Hi")
                            .font(.title3.bold())
                        Text("About.Description")
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Section("Get in touch") {
                LabeledContent("Email") { Text("contact@starlightapps.org") }
            }
            Section {
                HStack {
                    Button("Our Website") {
                        openURL(URL(string: "https://starlightapps.org/")!)
                    }
                    
                    Spacer()
                    
                    Button("Privacy Policy") {
                        openURL(URL(string: "http://starlightapps.org/privacy-policy")!)
                    }
                }
                .buttonStyle(.link)
            }
        }
        .formStyle(.grouped)
        .frame(maxWidth: .infinity)
    }
}

struct AboutMe_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
