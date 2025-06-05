//
//  Roadmap.swift
//  snApp
//
//  Created by Om Chachad on 05/02/23.
//

import SwiftUI

struct Roadmap: View {
    
    private struct RoadmapItem {
        let id = UUID()
        var title: LocalizedStringKey
        var symbol: String
        var description: LocalizedStringKey
    }

    private let roadmapItems: [RoadmapItem] = [
        RoadmapItem(title: "Roadmap.iOSApp", symbol: "iphone.gen3", description: "Roadmap.iOSApp.description"),
        RoadmapItem(title: "Roadmap.WindDown", symbol: "moon.zzz", description: "Roadmap.WindDown.description"),
        RoadmapItem(title: "Roadmap.IntelligentBreakthrough", symbol: "brain.head.profile", description: "Roadmap.IntelligentBreakthrough.description"),
        RoadmapItem(title: "Roadmap.DelayFriction", symbol: "hourglass.bottomhalf.filled", description: "Roadmap.DelayFriction.description")
    ]
    
    var body: some View {
        Form {
            Section {
                ForEach(roadmapItems, id: \.id) { item in
                    HStack {
                        Image(systemName: item.symbol)
                            .foregroundColor(.accentColor)
                            .font(.title2)
                        
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            
            Section("Roadmap.RequestFeature") {
                LabeledContent("Get in touch") { Text("contact@starlightapps.org") }
            }
        }
        .formStyle(.grouped)
    }
}

