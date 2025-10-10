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
    
    /// User's weight in kg
    @State private var weight: String = ""
    
    /// User's goal weight in kg
    @State private var goalWeight: String = ""
    
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
                    // Page 1: Welcome
                    welcomeScreen
                        .tag(0)
                    
                    // Page 2: Features
                    featuresScreen
                        .tag(1)
                    
                    // Page 3: Personal Setup
                    setupScreen
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
    
    // MARK: - Subviews
    
    /// Welcome screen
    private var welcomeScreen: some View {
        VStack(spacing: Constants.Spacing.extraLarge) {
            Spacer()
            
            // App logo or icon
            Image(systemName: "heart.circle.fill")
                .font(.system(size: 100, weight: .light))
                .foregroundColor(.brandPrimary)
                .accessibilityHidden(true)
            
            VStack(spacing: Constants.Spacing.medium) {
                Text("Welcome to")
                    .font(.titleMedium)
                    .foregroundColor(.secondary)
                
                Text("Fast To Habit")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("Your complete wellness companion for fasting, supplements, and healthy habits")
                    .font(.bodyRegular)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, Constants.Spacing.large)
                    .padding(.top, Constants.Spacing.small)
            }
            
            Spacer()
        }
        .padding(Constants.Spacing.large)
    }
    
    /// Features overview screen
    private var featuresScreen: some View {
        VStack(spacing: Constants.Spacing.large) {
            Spacer()
            
            VStack(spacing: Constants.Spacing.medium) {
                Text("Everything You Need")
                    .font(.titleLarge)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("All-in-one health tracking")
                    .font(.bodyRegular)
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: Constants.Spacing.medium) {
                featureRow(icon: "clock.fill", title: "Fasting Timer", description: "Track your eating windows", color: .brandPrimary)
                featureRow(icon: "pills.fill", title: "Supplements", description: "Manage daily supplements", color: .brandSecondary)
                featureRow(icon: "drop.fill", title: "Water Intake", description: "Stay hydrated", color: .brandAccent)
                featureRow(icon: "fork.knife", title: "Meal Planning", description: "Organize eating schedule", color: .brandPrimary)
                featureRow(icon: "scalemass.fill", title: "Weight Tracking", description: "Monitor your progress", color: .brandSecondary)
            }
            .padding(.horizontal, Constants.Spacing.large)
            
            Spacer()
        }
        .padding(Constants.Spacing.large)
    }
    
    /// Personal setup screen
    private var setupScreen: some View {
        VStack(spacing: Constants.Spacing.large) {
            Spacer()
            
            VStack(spacing: Constants.Spacing.medium) {
                Image(systemName: "person.fill")
                    .font(.system(size: 60, weight: .light))
                    .foregroundColor(.brandPrimary)
                    .accessibilityHidden(true)
                
                Text("Personalize Your Journey")
                    .font(.titleLarge)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Help us track your progress better")
                    .font(.bodyRegular)
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: Constants.Spacing.medium) {
                // Current Weight input
                VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                    Text("Current Weight (kg)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    TextField("70", text: $weight)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .font(.bodyRegular)
                        .accessibilityLabel("Current weight in kilograms")
                }
                
                // Goal Weight input
                VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                    Text("Goal Weight (kg)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    TextField("65", text: $goalWeight)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .font(.bodyRegular)
                        .accessibilityLabel("Goal weight in kilograms")
                }
                
                Text("You can skip this and add it later in settings")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, Constants.Spacing.small)
            }
            .padding(.horizontal, Constants.Spacing.large)
            
            Spacer()
        }
        .padding(Constants.Spacing.large)
    }
    
    /// Feature row component
    private func featureRow(icon: String, title: String, description: String, color: Color) -> some View {
        HStack(spacing: Constants.Spacing.medium) {
            Image(systemName: icon)
                .font(.system(size: Constants.IconSize.medium))
                .foregroundColor(color)
                .frame(width: 40)
                .accessibilityHidden(true)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .accessibilityElement(children: .combine)
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
        // Save user data if provided
        if !weight.isEmpty {
            UserDefaults.standard.set(weight, forKey: "userWeight")
        }
        if !goalWeight.isEmpty {
            UserDefaults.standard.set(goalWeight, forKey: "userGoalWeight")
        }
        
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
