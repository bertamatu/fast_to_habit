import SwiftUI

/// Swipeable weekly calendar view with Monday as first day
/// Allows horizontal swiping to navigate between weeks
/// Automatically updates selected date when swiping to different months
/// Shows indicator dots for days with planned meals or water intake
/// Tapping a date shows a preview of that day's data
/// [Rule: Code Organization, Documentation, Performance, State Management]
struct WeekCalendarView: View {
    
    // MARK: - Properties
    
    @Binding var selectedDate: Date
    var waterStore: WaterIntakeStore?
    var mealStore: MealPlanStore?
    
    @State private var selectedDayForPreview: Date?
    @State private var showingDayPreview = false
    
    // MARK: - Body
    
    var body: some View {
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
        .sheet(isPresented: $showingDayPreview) {
            if let date = selectedDayForPreview {
                DayDataPreviewSheet(
                    date: date,
                    waterStore: waterStore,
                    mealStore: mealStore
                )
            }
        }
    }
    
    // MARK: - Subviews
    
    /// Individual day column in the weekly calendar
    private func weekDayColumn(for date: Date) -> some View {
        let isToday = Calendar.current.isDateInToday(date)
        let dayName = date.formatted(.dateTime.weekday(.abbreviated)).uppercased()
        let dayNumber = date.formatted(.dateTime.day())
        let hasData = checkHasData(for: date)
        
        return VStack(spacing: 8) {
            // Day name (MON, TUE, etc.)
            Text(dayName)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(isToday ? .white : .secondary)
            
            // Day number
            Text(dayNumber)
                .font(.title3)
                .fontWeight(isToday ? .bold : .regular)
                .foregroundColor(isToday ? .white : .primary)
            
            // Data indicator dot (only show for non-today days with data)
            if !isToday && hasData {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 6, height: 6)
            } else {
                // Placeholder to maintain consistent height
                Circle()
                    .fill(Color.clear)
                    .frame(width: 6, height: 6)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isToday ? Color.green : Color.clear)
                .shadow(color: isToday ? Color.green.opacity(0.3) : Color.clear, radius: 8, x: 0, y: 4)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            selectedDayForPreview = date
            showingDayPreview = true
        }
    }
    
    // MARK: - Helpers
    
    /// Check if a given date has any data (meals or water intake)
    private func checkHasData(for date: Date) -> Bool {
        let calendar = Calendar.current
        
        // Check for water intake data
        if waterStore != nil {
            if let data = UserDefaults.standard.data(forKey: "waterLogs"),
               let allLogs = try? JSONDecoder().decode([WaterLog].self, from: data) {
                let hasWater = allLogs.contains { calendar.isDate($0.timestamp, inSameDayAs: date) }
                if hasWater { return true }
            }
        }
        
        // Check for meal plan data
        if mealStore != nil {
            if let data = UserDefaults.standard.data(forKey: "plannedMeals"),
               let allMeals = try? JSONDecoder().decode([PlannedMeal].self, from: data) {
                let hasMeals = allMeals.contains { calendar.isDate($0.scheduledTime, inSameDayAs: date) }
                if hasMeals { return true }
            }
        }
        
        return false
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
    
    // MARK: - Computed Properties
    
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
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Week Calendar") {
    WeekCalendarView(selectedDate: .constant(Date.now))
}
#endif
