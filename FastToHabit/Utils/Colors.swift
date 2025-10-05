//
//  Colors.swift
//  FastToHabit
//
//  Created by Berta Matuliauskiene on 05/10/2025.
//

import SwiftUI

/// App-wide color system with support for light and dark mode
/// [Rule: Design System - Colors]
extension Color {
    
    // MARK: - Brand Colors
    
    /// Primary brand color - used for fasting-related features
    /// Light: Blue #007AFF | Dark: Blue #0A84FF
    static let brandPrimary = Color("BrandPrimary")
    
    /// Secondary brand color - used for supplement-related features
    /// Light: Purple #AF52DE | Dark: Purple #BF5AF2
    static let brandSecondary = Color("BrandSecondary")
    
    /// Accent color - used for CTAs and important actions
    /// Light: Blue #007AFF | Dark: Blue #0A84FF
    static let brandAccent = Color("BrandAccent")
    
    // MARK: - Semantic Colors
    
    /// Color for active fasting state
    /// Light: Blue #007AFF | Dark: Blue #0A84FF
    static let fastingActive = Color("FastingActive")
    
    /// Color for completed fasting sessions
    /// Light: Green #34C759 | Dark: Green #30D158
    static let fastingComplete = Color("FastingComplete")
    
    /// Color for supplement reminders
    /// Light: Purple #AF52DE | Dark: Purple #BF5AF2
    static let supplementReminder = Color("SupplementReminder")
    
    /// Color for supplement taken/completed
    /// Light: Green #34C759 | Dark: Green #30D158
    static let supplementComplete = Color("SupplementComplete")
    
    // MARK: - Status Colors
    
    /// Success state color
    /// Light: Green #34C759 | Dark: Green #30D158
    static let success = Color("Success")
    
    /// Warning state color
    /// Light: Orange #FF9500 | Dark: Orange #FF9F0A
    static let warning = Color("Warning")
    
    /// Error state color
    /// Light: Red #FF3B30 | Dark: Red #FF453A
    static let error = Color("Error")
    
    /// Info state color
    /// Light: Blue #007AFF | Dark: Blue #0A84FF
    static let info = Color("Info")
    
    // MARK: - UI Colors
    
    /// Primary background color (adapts to light/dark mode)
    static let backgroundPrimary = Color("BackgroundPrimary")
    
    /// Secondary background color (for cards, elevated surfaces)
    static let backgroundSecondary = Color("BackgroundSecondary")
    
    /// Tertiary background color (for nested cards)
    static let backgroundTertiary = Color("BackgroundTertiary")
    
    /// Card background color
    static let cardBackground = Color("CardBackground")
    
    /// Primary text color (adapts to light/dark mode)
    static let textPrimary = Color.primary
    
    /// Secondary text color (less emphasis)
    static let textSecondary = Color.secondary
    
    /// Tertiary text color (hints, placeholders)
    static let textTertiary = Color("TextTertiary")
    
    /// Divider/separator color
    static let divider = Color("Divider")
    
    /// Border color
    static let border = Color("Border")
    
    // MARK: - Interactive Colors
    
    /// Button background color (primary)
    static let buttonPrimary = Color("ButtonPrimary")
    
    /// Button background color (secondary)
    static let buttonSecondary = Color("ButtonSecondary")
    
    /// Button text color
    static let buttonText = Color("ButtonText")
    
    /// Disabled state color
    static let disabled = Color("Disabled")
    
    // MARK: - Gradient Colors
    
    /// Gradient for fasting timer (start color)
    static let fastingGradientStart = Color("FastingGradientStart")
    
    /// Gradient for fasting timer (end color)
    static let fastingGradientEnd = Color("FastingGradientEnd")
    
    // MARK: - Helper Methods
    
    /// Creates a linear gradient for fasting timer
    static var fastingGradient: LinearGradient {
        LinearGradient(
            colors: [fastingGradientStart, fastingGradientEnd],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    /// Returns appropriate text color for given background color
    /// - Parameter backgroundColor: The background color to check contrast against
    /// - Returns: White or black text color for optimal contrast
    static func textColor(for backgroundColor: Color) -> Color {
        // This is a simplified version - for production, calculate actual luminance
        return .white
    }
}

// MARK: - Color Previews

#if DEBUG
/// Preview helper for testing colors in light and dark mode
struct ColorPreview: View {
    let color: Color
    let name: String
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                Text("Light/Dark Mode")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview("Brand Colors") {
    List {
        ColorPreview(color: .brandPrimary, name: "Brand Primary")
        ColorPreview(color: .brandSecondary, name: "Brand Secondary")
        ColorPreview(color: .brandAccent, name: "Brand Accent")
    }
}

#Preview("Semantic Colors") {
    List {
        ColorPreview(color: .fastingActive, name: "Fasting Active")
        ColorPreview(color: .fastingComplete, name: "Fasting Complete")
        ColorPreview(color: .supplementReminder, name: "Supplement Reminder")
        ColorPreview(color: .supplementComplete, name: "Supplement Complete")
    }
}

#Preview("Status Colors") {
    List {
        ColorPreview(color: .success, name: "Success")
        ColorPreview(color: .warning, name: "Warning")
        ColorPreview(color: .error, name: "Error")
        ColorPreview(color: .info, name: "Info")
    }
}
#endif
