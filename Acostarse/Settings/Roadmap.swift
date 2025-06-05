//
//  Roadmap.swift
//  snApp
//
//  Created by Om Chachad on 05/02/23.
//

import SwiftUI

struct Roadmap: View {
    
    private struct RoadmapItem {
        var title: String
        var symbol: String
        var description: String
    }

    private let roadmapItems: [RoadmapItem] = [
        RoadmapItem(title: "iOS App", symbol: "iphone.gen3", description: "Bringing over a bedtime reminder to iOS."),
        RoadmapItem(title: "Wind Down", symbol: "moon.zzz", description: "A reminder to nudge you to wind down before bedtime."),
        RoadmapItem(title: "Intelligent Breakthrough", symbol: "brain.head.profile", description: "A system to intelligently delay bedtime reminders based on ongoing important activities."),
        RoadmapItem(title: "Friction for Delaying Bedtime", symbol: "hourglass.bottomhalf.filled", description: "Adding friction to discourage delaying bedtime, ensuring a healthier sleep routine.")
    ]
    
    var body: some View {
        Form {
            Section {
                ForEach(roadmapItems, id: \.title) { item in
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
            
            Section("Have a feature you really want to see?") {
                LabeledContent("Get in touch") { Text("contact@starlightapps.org") }
            }
        }
        .formStyle(.grouped)
    }
}

