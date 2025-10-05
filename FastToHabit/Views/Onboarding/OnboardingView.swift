import SwiftUI

/// Main onboarding view with swipeable pages
/// Features: 3 key screens, page indicators, skip/get started buttons
/// [Rule: Onboarding Best Practices, User Experience, Accessibility]
struct OnboardingView: View {
    
    // MARK: - Properties
    
    /// Tracks onboarding completion
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    /// Current page index
    @State private var currentPage = 0
    
    /// Callback when onboarding is completed
    var onComplete: () -> Void
    
    // MARK: - Constants
    
    private let totalPages = 3
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Background
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Skip button
                HStack {
                    Spacer()
                    
                    if currentPage < totalPages - 1 {
                        Button("Skip") {
                            completeOnboarding()
                        }
                        .font(.bodyRegular)
                        .foregroundColor(.secondary)
                        .padding(Constants.Spacing.medium)
                        .accessibilityLabel("Skip onboarding")
                        .accessibilityHint("Go directly to the app")
                    }
                }
                
                // Onboarding pages
                TabView(selection: $currentPage) {
                    // Page 1: Track Fasting
                    OnboardingStepView(
                        icon: "clock.fill",
                        title: "Track Your Fasting",
                        description: "Monitor your intermittent fasting journey with easy-to-use timers and progress tracking.",
                        iconColor: .brandPrimary
                    )
                    .tag(0)
                    
                    // Page 2: Manage Supplements
                    OnboardingStepView(
                        icon: "pills.fill",
                        title: "Manage Supplements",
                        description: "Never miss a supplement with smart reminders and intake tracking.",
                        iconColor: .brandSecondary
                    )
                    .tag(1)
                    
                    // Page 3: Track Progress
                    OnboardingStepView(
                        icon: "chart.line.uptrend.xyaxis",
                        title: "Track Your Progress",
                        description: "Visualize your health journey with detailed insights and statistics.",
                        iconColor: .brandAccent
                    )
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .animation(.easeInOut, value: currentPage)
                
                // Bottom action button
                VStack(spacing: Constants.Spacing.medium) {
                    if currentPage == totalPages - 1 {
                        // Get Started button on last page
                        PrimaryButton(
                            title: "Get Started",
                            action: completeOnboarding,
                            icon: "arrow.right"
                        )
                        .padding(.horizontal, Constants.Spacing.large)
                        .accessibilityLabel("Get started with Fast To Habit")
                    } else {
                        // Next button on other pages
                        PrimaryButton(
                            title: "Next",
                            action: goToNextPage,
                            icon: "arrow.right"
                        )
                        .padding(.horizontal, Constants.Spacing.large)
                        .accessibilityLabel("Next page")
                        .accessibilityHint("Go to page \(currentPage + 2) of \(totalPages)")
                    }
                }
                .padding(.bottom, Constants.Spacing.extraLarge)
            }
        }
    }
    
    // MARK: - Actions
    
    /// Navigate to next page
    private func goToNextPage() {
        withAnimation {
            if currentPage < totalPages - 1 {
                currentPage += 1
            }
        }
    }
    
    /// Complete onboarding and dismiss
    private func completeOnboarding() {
        hasCompletedOnboarding = true
        onComplete()
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Onboarding View") {
    OnboardingView(onComplete: {
        print("Onboarding completed")
    })
}

#Preview("Onboarding View - Dark Mode") {
    OnboardingView(onComplete: {
        print("Onboarding completed")
    })
    .preferredColorScheme(.dark)
}
#endif
