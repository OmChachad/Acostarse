//
//  TipJar.swift
//  Linkeeper
//
//  Created by Om Chachad on 28/06/23.
//

import SwiftUI
import StoreKit

struct TipJar: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    
    @EnvironmentObject var storeKit: Store
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    VStack(alignment: .leading) {
                        Text("TipJar.whyTip")
                            .font(.title3.bold())
                            .padding(.vertical, 5)
                        
                        Text("TipJar.explanation")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("TipJar.PerksTitle")
                            .bold()
                            .padding(.vertical, 5)
                        
                        VStack(spacing: 5) {
                            bulletLine("TipJar.Appreciate", systemImage: "heart.fill", tint: .pink)
                            bulletLine("TipJar.Support", systemImage: "wrench.and.screwdriver.fill", tint: .blue)
                            bulletLine("TipJar.FacilitateUpdates", systemImage: "clock.arrow.2.circlepath", tint: .yellow)
                            bulletLine("TipJar.KeepFree", systemImage: "face.dashed", tint: .green)
                        }
                    }
                }
                
                VStack {
                    if storeKit.tippableProducts.isEmpty {
                        ProgressView()
                    } else {
                        ForEach(storeKit.tippableProducts) { product in
                            TipItem(product: product)
                                .environmentObject(storeKit)
                        }
                        
                        Divider()
                        
                        Text("""
                    TipJar.Disclaimer
                    """)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                .background(Color(nsColor: .controlBackgroundColor).opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button("Restore Purchases") {
                    Task {
                        try? await AppStore.sync()
                    }
                }
                
                Section {
                    Button {
                        openURL(URL(string:"https://apps.apple.com/app/id6746826547?mt=8&action=write-review")!)
                    } label: {
                        Label("Write a Review", systemImage: "square.and.pencil")
                    }
                } header: {
                    Text("TipJar.otherWaysToSupport")
                }
            }
            .padding(25)
        }
        .navigationTitle("Tip Jar")
        .frame(minWidth: 350, minHeight: 300)
    }
    
    func bulletLine(_ textContent: LocalizedStringKey, systemImage: String, tint: Color) -> some View {
        Label {
            Text(textContent)
        } icon: {
            Image(systemName: systemImage)
                .foregroundColor(tint)
                .frame(width: 10, alignment: .center)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TipItem: View {
    @EnvironmentObject var storeKit: Store
    var product: Product
    
    @State private var isPurchasing = false
    
    var body: some View {
        HStack {
            Text("\(storeKit.emoji(for: product.id)) ")
                .font(.largeTitle)
            
            VStack(alignment: .leading, spacing: 2.5) {
                Text("\(product.displayName)")
                    .bold()
                Text(product.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.trailing, 5)
            
            Spacer()
            
            if storeKit.isPurchased(product) {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
                    .frame(width: 70)
            } else if isPurchasing {
                ProgressView()
            } else {
                Button(product.displayPrice) {
                    isPurchasing = true
                    Task {
                        try? await storeKit.purchase(product)
                        isPurchasing = false
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct TipJar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TipJar()
                .environmentObject(Store.shared)
        }
    }
}
