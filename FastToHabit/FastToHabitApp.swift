//
//  FastToHabitApp.swift
//  FastToHabit
//
//  Created by Berta Matuliauskiene on 05/10/2025.
//

/*
 MEDICAL DISCLAIMER
 
 Fast To Habit is a wellness tracking tool for personal use only.
 It is not intended to diagnose, treat, cure, or prevent any disease
 or medical condition.
 
 The information provided by this app is for informational and
 educational purposes only and should not be considered medical advice.
 
 Always consult with a qualified healthcare provider before:
 - Starting any fasting regimen
 - Taking dietary supplements
 - Making changes to your diet or health routine
 - If you have any medical conditions or concerns
 
 This app is not a substitute for professional medical advice,
 diagnosis, or treatment.
 
 [Rule: Health App Compliance - Medical Disclaimer Required]
 */

import SwiftUI
import SwiftData

@main
struct FastToHabitApp: App {
    
    // MARK: - State
    
    @State private var showLaunchScreen = true
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    // MARK: - Model Container
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                // Main content or onboarding
                if hasCompletedOnboarding {
                    MainTabView()
                        .opacity(showLaunchScreen ? 0 : 1)
                } else {
                    OnboardingView(onComplete: {
                        // Onboarding completed
                    })
                    .opacity(showLaunchScreen ? 0 : 1)
                }
                
                // Launch screen overlay
                if showLaunchScreen {
                    LaunchScreen()
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
            .onAppear {
                // Hide launch screen after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        showLaunchScreen = false
                    }
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
