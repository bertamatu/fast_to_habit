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

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
