import SwiftUI

/// Design system preview showcasing all UI components and styles
/// Use this view to test and verify the design system
/// [Rule: Design System, Component Library, Documentation]
struct DesignSystemPreview: View {
    
    // MARK: - State
    
    @State private var isLoading = false
    @State private var showLoadingOverlay = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Constants.Layout.sectionSpacing) {
                    
                    // Colors Section
                    colorSection
                    
                    // Typography Section
                    typographySection
                    
                    // Buttons Section
                    buttonsSection
                    
                    // Cards Section
                    cardsSection
                    
                    // Empty State Section
                    emptyStateSection
                    
                    // Loading Section
                    loadingSection
                }
                .padding(Constants.Layout.screenPadding)
            }
            .navigationTitle("Design System")
            .overlay {
                if showLoadingOverlay {
                    LoadingView(message: "Loading...", isOverlay: true)
                }
            }
        }
    }
    
    // MARK: - Sections
    
    /// Colors showcase
    private var colorSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.medium) {
            sectionHeader("Colors")
            
            // Brand colors
            VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                Text("Brand Colors").font(.caption).foregroundColor(.secondary)
                HStack(spacing: Constants.Spacing.small) {
                    colorSwatch(color: .brandPrimary, name: "Primary")
                    colorSwatch(color: .brandSecondary, name: "Secondary")
                    colorSwatch(color: .brandAccent, name: "Accent")
                }
            }
            
            // Status colors
            VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                Text("Status Colors").font(.caption).foregroundColor(.secondary)
                HStack(spacing: Constants.Spacing.small) {
                    colorSwatch(color: .success, name: "Success")
                    colorSwatch(color: .warning, name: "Warning")
                    colorSwatch(color: .error, name: "Error")
                }
            }
        }
    }
    
    /// Typography showcase
    private var typographySection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.medium) {
            sectionHeader("Typography")
            
            Card {
                VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                    Text("Title Large").font(.titleLarge)
                    Text("Title Medium").font(.titleMedium)
                    Text("Title Small").font(.titleSmall)
                    Text("Headline").font(.headline)
                    Text("Body Regular").font(.bodyRegular)
                    Text("Caption").font(.caption)
                    Text("Display: 16:00").font(.displayLarge)
                }
            }
        }
    }
    
    /// Buttons showcase
    private var buttonsSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.medium) {
            sectionHeader("Buttons")
            
            VStack(spacing: Constants.Spacing.medium) {
                // Primary buttons
                PrimaryButton(title: "Primary Button", action: {})
                
                PrimaryButton(title: "With Icon", action: {}, icon: "play.fill")
                
                PrimaryButton(title: "Loading", action: {}, isLoading: true)
                
                PrimaryButton(title: "Disabled", action: {}, isDisabled: true)
                
                // Secondary buttons
                SecondaryButton(title: "Secondary Button", action: {})
                
                SecondaryButton(title: "With Icon", action: {}, icon: "pencil")
            }
        }
    }
    
    /// Cards showcase
    private var cardsSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.medium) {
            sectionHeader("Cards")
            
            // Simple card
            Card {
                Text("This is a simple card with default styling")
                    .font(.bodyRegular)
            }
            
            // Card with title
            Card(title: "Fasting Progress") {
                VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                    Text("16:8 Intermittent Fasting")
                        .font(.bodyRegular)
                    Text("12 hours remaining")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // Tappable card
            Card(title: "Tappable Card", onTap: {
                print("Card tapped!")
            }) {
                HStack {
                    Image(systemName: "hand.tap.fill")
                        .font(.system(size: Constants.IconSize.medium))
                        .foregroundColor(.brandPrimary)
                    
                    Text("Tap me to see haptic feedback")
                        .font(.bodySmall)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    /// Empty state showcase
    private var emptyStateSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.medium) {
            sectionHeader("Empty States")
            
            Card {
                EmptyStateView(
                    icon: "clock.badge.questionmark",
                    title: "No Active Fasts",
                    message: "Start your first fasting session",
                    actionTitle: "Start Fasting",
                    action: {}
                )
                .frame(height: 250)
            }
        }
    }
    
    /// Loading showcase
    private var loadingSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.medium) {
            sectionHeader("Loading States")
            
            Card {
                LoadingView(message: "Loading your data...")
                    .frame(height: 100)
            }
            
            PrimaryButton(title: "Show Loading Overlay", action: {
                showLoadingOverlay = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showLoadingOverlay = false
                }
            })
        }
    }
    
    // MARK: - Helper Views
    
    /// Section header
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.titleMedium)
            .foregroundColor(.primary)
    }
    
    /// Color swatch
    private func colorSwatch(color: Color, name: String) -> some View {
        VStack(spacing: Constants.Spacing.small) {
            RoundedRectangle(cornerRadius: Constants.CornerRadius.small)
                .fill(color)
                .frame(height: 60)
            
            Text(name)
                .font(.captionSmall)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Design System Preview") {
    DesignSystemPreview()
}

#Preview("Design System Dark Mode") {
    DesignSystemPreview()
        .preferredColorScheme(.dark)
}
#endif
