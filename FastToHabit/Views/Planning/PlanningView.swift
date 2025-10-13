import SwiftUI

/// Planning screen for meals, supplements, and water intake
/// Features: Meal planning, supplement schedule, water tracking
/// [Rule: Code Organization, Documentation]
struct PlanningView: View {
    
    // MARK: - State
    
    @State private var waterStore = WaterIntakeStore()
    @State private var mealStore = MealPlanStore()
    @State private var showingGoalSettings = false
    @State private var showingAddMeal = false
    @State private var editingMeal: PlannedMeal?
    @State private var selectedDate: Date = {
        // Initialize to the start of the current week (Monday)
        let calendar = Calendar.current
        let today = Date.now
        return calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: today).date ?? today
    }()
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top navigation bar with month selector and settings
                MonthSelectorView(
                    selectedDate: $selectedDate,
                    onSettingsTapped: {
                        showingGoalSettings = true
                    }
                )
                
                ScrollView {
                    VStack(spacing: Constants.Spacing.large) {
                        // Swipeable week calendar with data indicators
                        WeekCalendarView(
                            selectedDate: $selectedDate,
                            waterStore: waterStore,
                            mealStore: mealStore
                        )
                        
                        waterIntakeSection
                        mealPlanSection
                    }
                    .padding(Constants.Spacing.medium)
                }
                .background(Color.backgroundPrimary)
            }
            .onAppear {
                // Ensure we're showing today's week when view appears
                let calendar = Calendar.current
                let today = Date.now
                if let startOfWeek = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: today).date {
                    selectedDate = startOfWeek
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
            .sheet(isPresented: $showingAddMeal) {
                AddMealSheet(
                    meal: editingMeal,
                    onSave: { type, time, notes in
                        if let meal = editingMeal {
                            var updated = meal
                            updated.type = type
                            updated.scheduledTime = time
                            updated.notes = notes
                            mealStore.updateMeal(updated)
                        } else {
                            mealStore.addMeal(type: type, scheduledTime: time, notes: notes)
                        }
                        editingMeal = nil
                    }
                )
            }
        }
    }
    
    // MARK: - Sections
    
    /// Water intake tracking section with progress bar
    private var waterIntakeSection: some View {
        Card(title: "Water Intake") {
            VStack(spacing: Constants.Spacing.medium) {
                // Progress header
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(waterStore.todayGlassesCount)")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    Text("/\(waterStore.goal.dailyGoalGlasses)")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.secondary)
                    Text("glasses")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.leading, 4)
                    
                    Spacer()
                }
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Background
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.15))
                            .frame(height: 12)
                        
                        // Progress fill
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.29, green: 0.56, blue: 0.89),
                                        Color(red: 0.31, green: 0.79, blue: 0.91)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * waterStore.progress, height: 12)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: waterStore.progress)
                    }
                }
                .frame(height: 12)
                
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
    
    /// Meal planning section with scheduled meals
    private var mealPlanSection: some View {
        Card(title: "Meal Plan") {
            VStack(spacing: Constants.Spacing.medium) {
                if mealStore.todayMeals.isEmpty {
                    // Empty state
                    VStack(spacing: Constants.Spacing.medium) {
                        Image(systemName: "fork.knife")
                            .font(.system(size: 50))
                            .foregroundColor(.secondary)
                        
                        Text("No Meals Planned")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("Add your meals to plan your eating schedule")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Constants.Spacing.medium)
                } else {
                    // Meal list
                    ForEach(mealStore.sortedMeals) { meal in
                        mealRow(meal)
                    }
                }
                
                Divider()
                
                // Add meal button
                PrimaryButton(
                    title: "Add Meal",
                    action: {
                        editingMeal = nil
                        showingAddMeal = true
                    },
                    icon: "plus.circle.fill"
                )
            }
        }
    }
    
    /// Individual meal row
    private func mealRow(_ meal: PlannedMeal) -> some View {
        HStack(spacing: Constants.Spacing.medium) {
            // Checkbox
            Button {
                mealStore.toggleCompletion(for: meal.id)
            } label: {
                Image(systemName: meal.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(meal.isCompleted ? .green : .secondary)
            }
            
            // Meal info
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Image(systemName: meal.type.icon)
                        .foregroundColor(.brandPrimary)
                        .font(.subheadline)
                    
                    Text(meal.type.rawValue)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(meal.timeString)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let notes = meal.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            // Edit button
            Button {
                editingMeal = meal
                showingAddMeal = true
            } label: {
                Image(systemName: "pencil")
                    .foregroundColor(.brandPrimary)
            }
        }
        .padding(.vertical, 8)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                if let index = mealStore.sortedMeals.firstIndex(where: { $0.id == meal.id }) {
                    mealStore.deleteMeal(at: IndexSet(integer: index))
                }
            } label: {
                Label("Delete", systemImage: "trash")
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
