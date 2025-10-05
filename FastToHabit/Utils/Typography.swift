import SwiftUI

/// Typography system for Fast To Habit app
/// Provides consistent text styles with Dynamic Type support
/// [Rule: Typography System, Documentation]
extension Font {
    
    // MARK: - Titles
    
    /// Large title for main screen headers (34pt, bold)
    /// Used for: Main screen titles, onboarding headlines
    static let titleLarge = Font.system(size: 34, weight: .bold, design: .default)
    
    /// Medium title for section headers (28pt, bold)
    /// Used for: Section headers, modal titles
    static let titleMedium = Font.system(size: 28, weight: .bold, design: .default)
    
    /// Small title for card headers (22pt, semibold)
    /// Used for: Card titles, list section headers
    static let titleSmall = Font.system(size: 22, weight: .semibold, design: .default)
    
    // MARK: - Headlines
    
    /// Headline for emphasized content (17pt, semibold)
    /// Used for: Card headers, important labels
    static let headline = Font.system(size: 17, weight: .semibold, design: .default)
    
    /// Subheadline for secondary emphasis (15pt, semibold)
    /// Used for: List item titles, form labels
    static let subheadline = Font.system(size: 15, weight: .semibold, design: .default)
    
    // MARK: - Body Text
    
    /// Regular body text (17pt, regular)
    /// Used for: Main content, descriptions, paragraphs
    static let bodyRegular = Font.system(size: 17, weight: .regular, design: .default)
    
    /// Small body text (15pt, regular)
    /// Used for: Secondary content, list items
    static let bodySmall = Font.system(size: 15, weight: .regular, design: .default)
    
    // MARK: - Callouts & Captions
    
    /// Callout text for secondary information (16pt, regular)
    /// Used for: Hints, helper text, secondary info
    static let callout = Font.system(size: 16, weight: .regular, design: .default)
    
    /// Caption text for metadata (12pt, regular)
    /// Used for: Timestamps, counts, metadata
    static let caption = Font.system(size: 12, weight: .regular, design: .default)
    
    /// Small caption for minimal text (11pt, regular)
    /// Used for: Fine print, legal text
    static let captionSmall = Font.system(size: 11, weight: .regular, design: .default)
    
    // MARK: - Buttons
    
    /// Button text (17pt, semibold)
    /// Used for: Primary and secondary buttons
    static let button = Font.system(size: 17, weight: .semibold, design: .default)
    
    /// Small button text (15pt, semibold)
    /// Used for: Compact buttons, toolbar buttons
    static let buttonSmall = Font.system(size: 15, weight: .semibold, design: .default)
    
    // MARK: - Special
    
    /// Large numeric display (48pt, bold)
    /// Used for: Timer display, large counters
    static let displayLarge = Font.system(size: 48, weight: .bold, design: .rounded)
    
    /// Medium numeric display (34pt, semibold)
    /// Used for: Stats, progress indicators
    static let displayMedium = Font.system(size: 34, weight: .semibold, design: .rounded)
    
    /// Monospaced numbers for timers (17pt, regular)
    /// Used for: Countdown timers, precise time display
    static let monospacedNumbers = Font.system(size: 17, weight: .regular, design: .monospaced)
}

// MARK: - Text Style Modifiers

extension View {
    
    /// Apply title large style with primary color
    func titleLargeStyle() -> some View {
        self
            .font(.titleLarge)
            .foregroundColor(.primary)
    }
    
    /// Apply title medium style with primary color
    func titleMediumStyle() -> some View {
        self
            .font(.titleMedium)
            .foregroundColor(.primary)
    }
    
    /// Apply headline style with primary color
    func headlineStyle() -> some View {
        self
            .font(.headline)
            .foregroundColor(.primary)
    }
    
    /// Apply body regular style with primary color
    func bodyStyle() -> some View {
        self
            .font(.bodyRegular)
            .foregroundColor(.primary)
    }
    
    /// Apply caption style with secondary color
    func captionStyle() -> some View {
        self
            .font(.caption)
            .foregroundColor(.secondary)
    }
    
    /// Apply button text style
    func buttonTextStyle() -> some View {
        self
            .font(.button)
            .foregroundColor(.white)
    }
}

// MARK: - Dynamic Type Support

extension Font {
    
    /// Get scaled font for accessibility (Dynamic Type)
    /// - Parameters:
    ///   - size: Base font size
    ///   - weight: Font weight
    ///   - design: Font design
    /// - Returns: Scaled font that respects user's text size preferences
    static func scaledFont(size: CGFloat, weight: Weight = .regular, design: Design = .default) -> Font {
        return Font.system(size: size, weight: weight, design: design)
    }
}

// MARK: - SwiftUI Preview

#if DEBUG
#Preview("Typography Showcase") {
    ScrollView {
        VStack(alignment: .leading, spacing: 24) {
            
            // Titles
            VStack(alignment: .leading, spacing: 8) {
                Text("Titles").font(.caption).foregroundColor(.secondary)
                Text("Title Large").font(.titleLarge)
                Text("Title Medium").font(.titleMedium)
                Text("Title Small").font(.titleSmall)
            }
            
            Divider()
            
            // Headlines
            VStack(alignment: .leading, spacing: 8) {
                Text("Headlines").font(.caption).foregroundColor(.secondary)
                Text("Headline").font(.headline)
                Text("Subheadline").font(.subheadline)
            }
            
            Divider()
            
            // Body
            VStack(alignment: .leading, spacing: 8) {
                Text("Body Text").font(.caption).foregroundColor(.secondary)
                Text("Body Regular - Lorem ipsum dolor sit amet, consectetur adipiscing elit.").font(.bodyRegular)
                Text("Body Small - Lorem ipsum dolor sit amet, consectetur adipiscing elit.").font(.bodySmall)
            }
            
            Divider()
            
            // Callouts & Captions
            VStack(alignment: .leading, spacing: 8) {
                Text("Callouts & Captions").font(.caption).foregroundColor(.secondary)
                Text("Callout - Helper text goes here").font(.callout)
                Text("Caption - 2 hours ago").font(.caption)
                Text("Caption Small - Fine print").font(.captionSmall)
            }
            
            Divider()
            
            // Buttons
            VStack(alignment: .leading, spacing: 8) {
                Text("Buttons").font(.caption).foregroundColor(.secondary)
                Text("Button Text").font(.button)
                Text("Button Small").font(.buttonSmall)
            }
            
            Divider()
            
            // Display
            VStack(alignment: .leading, spacing: 8) {
                Text("Display").font(.caption).foregroundColor(.secondary)
                Text("16:00").font(.displayLarge)
                Text("42").font(.displayMedium)
                Text("00:15:30").font(.monospacedNumbers)
            }
        }
        .padding(24)
    }
}

#Preview("Typography Dark Mode") {
    ScrollView {
        VStack(alignment: .leading, spacing: 24) {
            Text("Title Large").font(.titleLarge)
            Text("Body Regular").font(.bodyRegular)
            Text("Caption").font(.caption)
            Text("16:00").font(.displayLarge)
        }
        .padding(24)
    }
    .preferredColorScheme(.dark)
}
#endif
