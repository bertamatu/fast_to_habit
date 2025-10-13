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
    @State private var selectedDate = Date.now
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top navigation bar with month selector and settings
                topNavigationBar
                
                ScrollView {
                    VStack(spacing: Constants.Spacing.large) {
                        weekCalendar
                        waterIntakeSection
                        mealPlanSection
                    }
                    .padding(Constants.Spacing.medium)
                }
                .background(Color.backgroundPrimary)
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
    
    /// Top navigation bar with month selector and settings icon
    private var topNavigationBar: some View {
        HStack {
            // Month selector with dropdown of all months
            Menu {
                ForEach(availableMonths, id: \.self) { date in
                    Button {
                        selectedDate = date
                    } label: {
                        HStack {
                            Text(date.formatted(.dateTime.month(.wide).year()))
                            if Calendar.current.isDate(date, equalTo: selectedDate, toGranularity: .month) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: 8) {
                    Text(selectedDate.formatted(.dateTime.month(.wide).year()))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Image(systemName: "chevron.down")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()
            
            // Settings button
            Button {
                showingGoalSettings = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.title2)
                    .foregroundColor(.brandPrimary)
            }
        }
        .padding(.horizontal, Constants.Spacing.medium)
        .padding(.vertical, Constants.Spacing.small)
        .background(Color.backgroundPrimary)
    }
    
    /// Weekly calendar view with Monday as first day - swipeable to change weeks
    private var weekCalendar: some View {
        TabView(selection: $selectedDate) {
            ForEach(availableWeeks, id: \.self) { weekStartDate in
                HStack(spacing: 0) {
                    ForEach(getWeekDays(from: weekStartDate), id: \.self) { date in
                        weekDayColumn(for: date)
                    }
                }
                .tag(weekStartDate)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 100)
        .onChange(of: selectedDate) { oldValue, newValue in
            // Update month selector when week changes to a different month
            if !Calendar.current.isDate(oldValue, equalTo: newValue, toGranularity: .month) {
                // Month changed, no additional action needed as selectedDate already updated
            }
        }
    }
    
    /// Individual day column in the weekly calendar
    private func weekDayColumn(for date: Date) -> some View {
        let isToday = Calendar.current.isDateInToday(date)
        let dayName = date.formatted(.dateTime.weekday(.abbreviated)).uppercased()
        let dayNumber = date.formatted(.dateTime.day())
        
        return VStack(spacing: 8) {
            // Day name (MON, TUE, etc.)
            Text(dayName)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(isToday ? .primary : .secondary)
            
            // Day number
            Text(dayNumber)
                .font(.title3)
                .fontWeight(isToday ? .bold : .regular)
                .foregroundColor(.primary)
            
            // Indicator dot for today
            Circle()
                .fill(isToday ? Color.primary : Color.clear)
                .frame(width: 6, height: 6)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isToday ? Color.primary.opacity(0.1) : Color.clear)
        )
    }
    
    /// Computed property to get the current week starting from Monday
    private var weekDays: [Date] {
        return getWeekDays(from: selectedDate)
    }
    
    /// Helper function to get week days for a given date
    private func getWeekDays(from date: Date) -> [Date] {
        let calendar = Calendar.current
        
        // Get the start of the week (Monday) for the given date
        let startOfWeek = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: date).date!
        
        // Ensure Monday is the first day
        var weekDays: [Date] = []
        for dayOffset in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) {
                weekDays.append(day)
            }
        }
        
        return weekDays
    }
    
    /// Computed property to generate available months (6 months back, current, 6 months forward)
    private var availableMonths: [Date] {
        let calendar = Calendar.current
        let today = Date.now
        var months: [Date] = []
        
        // Generate months from 6 months ago to 6 months in the future
        for monthOffset in -6...6 {
            if let month = calendar.date(byAdding: .month, value: monthOffset, to: today),
               let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month)) {
                months.append(firstDayOfMonth)
            }
        }
        
        return months
    }
    
    /// Computed property to generate available weeks (for swipeable calendar)
    private var availableWeeks: [Date] {
        let calendar = Calendar.current
        let today = Date.now
        var weeks: [Date] = []
        
        // Generate weeks from 12 weeks ago to 12 weeks in the future
        for weekOffset in -12...12 {
            if let week = calendar.date(byAdding: .weekOfYear, value: weekOffset, to: today),
               let startOfWeek = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: week).date {
                weeks.append(startOfWeek)
            }
        }
        
        return weeks
    }
    
    // MARK: - Actions
    
    /// Changes the selected month by the specified offset
    private func changeMonth(by offset: Int) {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: offset, to: selectedDate) {
            selectedDate = newDate
        }
    }
    
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
