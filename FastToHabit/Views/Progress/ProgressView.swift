import SwiftUI

/// Progress tracking screen
/// Features: Weight tracking, fasting statistics, recent activity
/// [Rule: Code Organization, Documentation, Data Visualization]
struct ProgressView: View {
    
    // MARK: - State
    
    @AppStorage("userWeight") private var currentWeight: String = ""
    @AppStorage("userGoalWeight") private var goalWeight: String = ""
    
    // Computed property to check if we have any data
    private var hasData: Bool {
        !currentWeight.isEmpty
    }
    
    // Calculate weight difference
    private var weightDifference: Double? {
        guard let current = Double(currentWeight),
              let goal = Double(goalWeight) else { return nil }
        return current - goal
    }
    
    // Calculate progress percentage
    private var weightProgress: Double {
        guard let current = Double(currentWeight),
              let goal = Double(goalWeight),
              goal > 0 else { return 0 }
        
        // Assuming starting weight was higher, calculate how close to goal
        let difference = current - goal
        if difference <= 0 {
            return 1.0 // Goal reached or exceeded
        }
        // This is simplified - in real app, you'd track starting weight
        return max(0, min(1.0, 1.0 - (difference / current)))
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Constants.Spacing.large) {
                    if hasData {
                        // Weight Progress Section
                        weightProgressSection
                        
                        // Weight Goal Section
                        if !goalWeight.isEmpty {
                            weightGoalSection
                        }
                    } else {
                        // Empty State
                        emptyStateView
                    }
                }
                .padding(Constants.Spacing.medium)
            }
            .background(Color.backgroundPrimary)
            .navigationTitle("Progress")
        }
    }
    
    // MARK: - Sections
    
    /// Weight progress card with chart
    private var weightProgressSection: some View {
        Card(title: "Weight Tracking") {
            VStack(spacing: Constants.Spacing.medium) {
                if !currentWeight.isEmpty {
                    // Current weight display
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Current Weight")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text("\(currentWeight) kg")
                                .font(.titleLarge)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                        
                        // Status indicator
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("Status")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            HStack(spacing: 4) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.caption)
                                Text("Set")
                                    .font(.subheadline)
                            }
                            .foregroundColor(.success)
                        }
                    }
                    
                    Divider()
                    
                    // Info message
                    HStack(spacing: 8) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.brandPrimary)
                        Text("Update your weight in Settings to track progress over time")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } else {
                    // No weight set
                    VStack(spacing: Constants.Spacing.medium) {
                        Image(systemName: "scalemass")
                            .font(.system(size: 50))
                            .foregroundColor(.secondary)
                        
                        Text("No Weight Recorded")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("Add your weight in Settings or during onboarding to track your progress")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Constants.Spacing.small)
                }
            }
        }
    }
    
    /// Weight goal section with progress
    private var weightGoalSection: some View {
        Card(title: "Weight Goal") {
            VStack(spacing: Constants.Spacing.medium) {
                // Goal info
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Target Weight")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("\(goalWeight) kg")
                            .font(.titleMedium)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    if let diff = weightDifference {
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("To Go")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            HStack(spacing: 4) {
                                if diff > 0 {
                                    Image(systemName: "arrow.down")
                                        .font(.caption)
                                    Text(String(format: "%.1f kg", diff))
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                } else {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.caption)
                                    Text("Goal Reached!")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                            }
                            .foregroundColor(diff > 0 ? .brandPrimary : .success)
                        }
                    }
                }
                
                // Progress bar
                if weightProgress > 0 {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Progress to Goal")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("\(Int(weightProgress * 100))%")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.brandPrimary)
                        }
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 8)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.brandPrimary)
                                    .frame(width: geometry.size.width * weightProgress, height: 8)
                            }
                        }
                        .frame(height: 8)
                    }
                }
            }
        }
    }
    
    
    /// Empty state when no data
    private var emptyStateView: some View {
        VStack(spacing: Constants.Spacing.large) {
            Spacer()
            
            EmptyStateView(
                icon: "scalemass",
                title: "No Weight Data Yet",
                message: "Add your weight in Settings or during onboarding to track your progress",
                actionTitle: "Go to Settings",
                action: {
                    // TODO: Navigate to Settings tab
                }
            )
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Progress View") {
    ProgressView()
}

#Preview("Progress View - Dark") {
    ProgressView()
        .preferredColorScheme(.dark)
}
#endif
