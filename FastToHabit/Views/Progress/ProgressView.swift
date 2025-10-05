import SwiftUI

/// Progress tracking screen
/// Features: Weight tracking, fasting statistics, recent activity
/// [Rule: Code Organization, Documentation, Data Visualization]
struct ProgressView: View {
    
    // MARK: - State
    
    @AppStorage("userWeight") private var currentWeight: String = ""
    @State private var hasData = false // TODO: Connect to real data
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Constants.Spacing.large) {
                    if hasData {
                        // Weight Progress Section
                        weightProgressSection
                        
                        // Fasting Stats Section
                        fastingStatsSection
                        
                        // Recent Activity Section
                        recentActivitySection
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
        Card(title: "Weight Progress") {
            VStack(spacing: Constants.Spacing.medium) {
                // Current weight display
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Current Weight")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(currentWeight.isEmpty ? "--" : "\(currentWeight) kg")
                            .font(.titleLarge)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    // Change indicator (placeholder)
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.down")
                            .font(.caption)
                        Text("2.5 kg")
                            .font(.subheadline)
                    }
                    .foregroundColor(.success)
                }
                
                // Chart placeholder
                VStack {
                    HStack(alignment: .bottom, spacing: 8) {
                        ForEach(0..<7) { index in
                            VStack {
                                Spacer()
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.brandPrimary.opacity(0.7))
                                    .frame(height: CGFloat.random(in: 40...120))
                            }
                        }
                    }
                    .frame(height: 120)
                    
                    Text("Last 7 days")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.top, Constants.Spacing.small)
            }
        }
    }
    
    /// Fasting statistics cards
    private var fastingStatsSection: some View {
        VStack(spacing: Constants.Spacing.medium) {
            Text("Fasting Stats")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Stats grid
            HStack(spacing: Constants.Spacing.medium) {
                // Total Fasts
                statCard(
                    title: "Total Fasts",
                    value: "12",
                    icon: "checkmark.circle.fill",
                    color: .brandPrimary
                )
                
                // Current Streak
                statCard(
                    title: "Streak",
                    value: "5 days",
                    icon: "flame.fill",
                    color: .brandSecondary
                )
            }
            
            HStack(spacing: Constants.Spacing.medium) {
                // This Week
                statCard(
                    title: "This Week",
                    value: "4",
                    icon: "calendar",
                    color: .brandAccent
                )
                
                // Average Duration
                statCard(
                    title: "Avg Duration",
                    value: "16h",
                    icon: "clock.fill",
                    color: .success
                )
            }
        }
    }
    
    /// Recent activity list
    private var recentActivitySection: some View {
        Card(title: "Recent Activity") {
            VStack(spacing: Constants.Spacing.small) {
                ForEach(0..<5) { index in
                    HStack {
                        // Date
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Oct \(5 - index)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("16:8 Fast")
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        
                        Spacer()
                        
                        // Duration
                        HStack(spacing: 4) {
                            Image(systemName: "clock.fill")
                                .font(.caption)
                                .foregroundColor(.brandPrimary)
                            Text("16h 30m")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                        
                        // Status
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.success)
                    }
                    
                    if index < 4 {
                        Divider()
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
                icon: "chart.line.uptrend.xyaxis",
                title: "No Progress Data Yet",
                message: "Start tracking your fasts and weight to see your progress here",
                actionTitle: "Start Fasting",
                action: {
                    // TODO: Navigate to Fast tab
                }
            )
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Helper Views
    
    /// Stat card component
    private func statCard(title: String, value: String, icon: String, color: Color) -> some View {
        VStack(spacing: Constants.Spacing.small) {
            Image(systemName: icon)
                .font(.system(size: Constants.IconSize.medium))
                .foregroundColor(color)
            
            Text(value)
                .font(.titleMedium)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(Constants.Spacing.medium)
        .background(Color.cardBackground)
        .cornerRadius(Constants.CornerRadius.medium)
        .shadow(
            color: .black.opacity(0.05),
            radius: 4,
            x: 0,
            y: 2
        )
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
