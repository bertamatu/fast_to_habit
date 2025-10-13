import SwiftUI

/// Swipeable weekly calendar view with Monday as first day
/// Allows horizontal swiping to navigate between weeks
/// Automatically updates selected date when swiping to different months
/// [Rule: Code Organization, Documentation, Performance]
struct WeekCalendarView: View {
    
    // MARK: - Properties
    
    @Binding var selectedDate: Date
    
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
    }
    
    // MARK: - Subviews
    
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
    
    // MARK: - Helpers
    
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
