import SwiftUI

/// Planning screen for meals, supplements, and water intake
/// Features: Meal planning, supplement schedule, water tracking
/// [Rule: Code Organization, Documentation]
struct PlanningView: View {
    
    // MARK: - State
    
    @State private var waterStore = WaterIntakeStore()
    @State private var showingGoalSettings = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Constants.Spacing.large) {
                    waterIntakeSection
                }
                .padding(Constants.Spacing.medium)
            }
            .background(Color.backgroundPrimary)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingGoalSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.brandPrimary)
                    }
                }
            }
            .sheet(isPresented: $showingGoalSettings) {
                WaterGoalSettingsSheet(
                    goal: waterStore.goal,
                    onSave: { newGoal in
                        waterStore.updateGoal(newGoal)
                    }
                )
            }
        }
    }
    
    // MARK: - Sections
    
    /// Water intake tracking section with progress ring
    private var waterIntakeSection: some View {
        Card(title: "Water Intake") {
            VStack(spacing: Constants.Spacing.large) {
                // Progress ring
                WaterProgressRing(
                    progress: waterStore.progress,
                    totalGlasses: waterStore.goal.dailyGoalGlasses,
                    consumedGlasses: waterStore.todayGlassesCount
                )
                .padding(.vertical, Constants.Spacing.medium)
                
                // Goal summary
                HStack(spacing: Constants.Spacing.large) {
                    goalMetric(
                        icon: "drop.fill",
                        value: "\(waterStore.todayTotalMl)ml",
                        label: "Today"
                    )
                    
                    Divider()
                        .frame(height: 40)
                    
                    goalMetric(
                        icon: "target",
                        value: "\(waterStore.goal.dailyGoalMl)ml",
                        label: "Goal"
                    )
                    
                    Divider()
                        .frame(height: 40)
                    
                    goalMetric(
                        icon: "clock.fill",
                        value: "\(waterStore.remainingGlasses)",
                        label: "Remaining"
                    )
                }
                .padding(.horizontal, Constants.Spacing.medium)
                
                Divider()
                
                // Action buttons
                VStack(spacing: Constants.Spacing.small) {
                    PrimaryButton(
                        title: "Log a Glass (\(waterStore.goal.glassSize)ml)",
                        action: {
                            waterStore.logWater()
                        },
                        icon: "plus.circle.fill"
                    )
                    
                    if !waterStore.todayLogs.isEmpty {
                        SecondaryButton(
                            title: "Undo Last",
                            action: {
                                waterStore.undoLastLog()
                            },
                            icon: "arrow.uturn.backward"
                        )
                    }
                }
            }
        }
    }
    
    /// Helper view for goal metrics
    private func goalMetric(icon: String, value: String, label: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.brandPrimary)
            
            Text(value)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.primary)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
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
