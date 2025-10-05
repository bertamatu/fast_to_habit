import SwiftUI

/// Planning screen for meals, supplements, and water intake
/// Features: Meal planning, supplement schedule, water tracking
/// [Rule: Code Organization, Documentation]
struct PlanningView: View {
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                // Placeholder content
                VStack(spacing: Constants.Spacing.large) {
                    Image(systemName: "calendar")
                        .font(.system(size: Constants.IconSize.extraLarge))
                        .foregroundColor(.brandSecondary)
                    
                    Text("Planning")
                        .font(.titleLarge)
                        .foregroundColor(.primary)
                    
                    Text("Organize your meals and supplements")
                        .font(.bodyRegular)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(Constants.Spacing.large)
            }
            .navigationTitle("Planning")
        }
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Planning View") {
    PlanningView()
}

#Preview("Planning View - Dark") {
    PlanningView()
        .preferredColorScheme(.dark)
}
#endif
