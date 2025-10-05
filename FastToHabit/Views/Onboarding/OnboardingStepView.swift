import SwiftUI

/// Reusable onboarding step component
/// Features: Icon, title, description, consistent styling
/// [Rule: Onboarding Best Practices, Component Library, Accessibility]
struct OnboardingStepView: View {
    
    // MARK: - Properties
    
    /// SF Symbol icon name
    let icon: String
    
    /// Step title
    let title: String
    
    /// Step description
    let description: String
    
    /// Icon color (defaults to brand primary)
    var iconColor: Color = .brandPrimary
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: Constants.Spacing.extraLarge) {
            Spacer()
            
            // Icon
            Image(systemName: icon)
                .font(.system(size: Constants.IconSize.extraLarge + 32, weight: .light))
                .foregroundColor(iconColor)
                .accessibilityHidden(true)
            
            // Content
            VStack(spacing: Constants.Spacing.medium) {
                Text(title)
                    .font(.titleLarge)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                
                Text(description)
                    .font(.bodyRegular)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, Constants.Spacing.large)
            }
            
            Spacer()
        }
        .padding(Constants.Spacing.large)
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Onboarding Step - Fasting") {
    OnboardingStepView(
        icon: "clock.fill",
        title: "Track Your Fasting",
        description: "Monitor your intermittent fasting journey with easy-to-use timers and progress tracking.",
        iconColor: .brandPrimary
    )
}

#Preview("Onboarding Step - Supplements") {
    OnboardingStepView(
        icon: "pills.fill",
        title: "Manage Supplements",
        description: "Never miss a supplement with smart reminders and intake tracking.",
        iconColor: .brandSecondary
    )
}

#Preview("Onboarding Step - Dark Mode") {
    OnboardingStepView(
        icon: "chart.line.uptrend.xyaxis",
        title: "Track Progress",
        description: "Visualize your health journey with detailed insights and statistics.",
        iconColor: .brandAccent
    )
    .preferredColorScheme(.dark)
}
#endif
