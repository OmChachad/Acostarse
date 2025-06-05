//
//  OnboardingController.swift
//  Acostarse
//
//  Created by Om Chachad on 6/5/25.
//

import SwiftUI
import ServiceManagement

struct OnboardingController: View {
    @AppStorage("firstOnboardingCompletionDate") private var onboardingCompletedDate: Date?
    
    @Environment(\.colorScheme) var colorScheme
    
    enum Page: Int {
        case welcome = 1
        case bedtimeConfig = 2
        case strictMode = 3
        case menuBar = 4
        case final = 5
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .welcome:
                WelcomeView()
            case .bedtimeConfig:
                BedtimeConfigurationView()
            case .strictMode:
                Customization()
            case .menuBar:
                MenuBarHighlighter()
            case .final:
                StartUsingView()
            }
        }
    }
    
    @State private var currentPage: Page = .welcome
    
    @State private var isLoadedStage1 = false
    @State private var isLoadedStage2 = false
    
    var completionAction: () -> Void
    
    var body: some View {
        ZStack {
            if isLoadedStage1 {
                VStack {
                    currentPage.view
                        .padding()
                        .transition(.blurReplace)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.vertical, 50)
                }
                .overlay(alignment: .bottom) {
                    HStack {
                        if currentPage != .welcome {
                            Button("Back", systemImage: "chevron.left") {
                                if let previousPage = Page(rawValue: currentPage.rawValue - 1) {
                                    withAnimation {
                                        currentPage = previousPage
                                    }
                                }
                            }
                            .buttonStyle(OnboardingButtonStyle())
                            .labelStyle(.iconOnly)
                        }
                        
                        Spacer()
                        
                        if currentPage != .final && isLoadedStage2 {
                            Button("Next", systemImage: "chevron.right") {
                                if let nextPage = Page(rawValue: currentPage.rawValue + 1) {
                                    withAnimation {
                                        currentPage = nextPage
                                    }
                                }
                            }
                            .labelStyle(.iconOnly)
                            .buttonStyle(OnboardingButtonStyle())
                        } else if currentPage == .final {
                            Button("Start Using") {
                                if onboardingCompletedDate == nil {
                                    onboardingCompletedDate = Date.now
                                    
                                    // Start up at login.
                                    try? SMAppService.mainApp.register()
                                }
                                
                                withAnimation(.spring(duration: 1.5)) {
                                    isLoadedStage1 = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    completionAction()
                                }
                            }
                            .buttonStyle(OnboardingButtonStyle())
                        }
                    }
                    .padding()
                }
                
                .background {
                    VisualEffectView()
                        .clipShape(.rect(cornerRadius: 16, style: .continuous))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke((colorScheme == .dark ? Color.secondary : Color.gray).opacity(0.3), lineWidth: 1.5)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .shadow(radius: 10, y: 5)
                }
                .padding(25)
                .transition(.blurReplace)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            Task {
                withAnimation(.spring(duration: 1.5)) {
                    isLoadedStage1 = true
                }
                
                try? await Task.sleep(nanoseconds: 1500000000)
                
                withAnimation(.spring(duration: 1.5)) {
                    isLoadedStage2 = true
                }
            }
        }
    }
}

struct OnboardingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .bold()
            .padding(10)
            .padding(.horizontal, 10)
            .background((configuration.isPressed ? Color.accentColor.opacity(0.7) : Color.accentColor).gradient)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(radius: 5, y: 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

#Preview {
    OnboardingController {
        
    }
}
