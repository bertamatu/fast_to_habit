import SwiftUI

/// Empty state view for lists and screens with no content
/// Features: Icon, title, message, optional action button
/// [Rule: Component Library, Documentation, User Experience]
struct EmptyStateView: View {
    
    // MARK: - Properties
    
    /// SF Symbol icon name
    let icon: String
    
    /// Title text
    let title: String
    
    /// Message text
    let message: String
    
    /// Optional action button title
    var actionTitle: String? = nil
    
    /// Optional action to perform
    var action: (() -> Void)? = nil
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: Constants.Spacing.large) {
            // Icon
            Image(systemName: icon)
                .font(.system(size: Constants.IconSize.extraLarge, weight: .light))
                .foregroundColor(.secondary)
            
            // Title and message
            VStack(spacing: Constants.Spacing.small) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                Text(message)
                    .font(.bodySmall)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            // Action button if provided
            if let actionTitle = actionTitle, let action = action {
                PrimaryButton(title: actionTitle, action: action)
                    .frame(maxWidth: 250)
            }
        }
        .padding(Constants.Spacing.extraLarge)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Empty State Variants") {
    VStack(spacing: 40) {
        // With action button
        EmptyStateView(
            icon: "clock.badge.questionmark",
            title: "No Active Fasts",
            message: "Start your first intermittent fasting session to track your progress",
            actionTitle: "Start Fasting",
            action: {}
        )
        .frame(height: 300)
        
        Divider()
        
        // Without action button
        EmptyStateView(
            icon: "pills",
            title: "No Supplements Added",
            message: "Add your first supplement to start tracking your daily intake"
        )
        .frame(height: 250)
    }
}

#Preview("Empty State Examples") {
    TabView {
        // Fasting empty state
        EmptyStateView(
            icon: "clock.badge.questionmark",
            title: "No Active Fasts",
            message: "Start your first intermittent fasting session to track your progress",
            actionTitle: "Start Fasting",
            action: {}
        )
        .tabItem {
            Label("Fasting", systemImage: "clock")
        }
        
        // Supplements empty state
        EmptyStateView(
            icon: "pills",
            title: "No Supplements",
            message: "Add supplements to track your daily intake and set reminders",
            actionTitle: "Add Supplement",
            action: {}
        )
        .tabItem {
            Label("Supplements", systemImage: "pills")
        }
        
        // History empty state
        EmptyStateView(
            icon: "chart.line.uptrend.xyaxis",
            title: "No History Yet",
            message: "Complete your first fasting session to see your progress here"
        )
        .tabItem {
            Label("History", systemImage: "chart.line.uptrend.xyaxis")
        }
    }
}

#Preview("Empty State Dark Mode") {
    EmptyStateView(
        icon: "clock.badge.questionmark",
        title: "No Active Fasts",
        message: "Start your first intermittent fasting session to track your progress",
        actionTitle: "Start Fasting",
        action: {}
    )
    .preferredColorScheme(.dark)
}
#endif
