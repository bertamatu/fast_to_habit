import SwiftUI

/// Sheet displaying a preview of data for a selected day
/// Shows water intake logs and planned meals for the date
/// [Rule: Code Organization, Documentation]
struct DayDataPreviewSheet: View {
    
    // MARK: - Properties
    
    let date: Date
    var waterStore: WaterIntakeStore?
    var mealStore: MealPlanStore?
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Computed Properties
    
    /// Water logs for the selected date
    private var waterLogs: [WaterLog] {
        guard let data = UserDefaults.standard.data(forKey: "waterLogs"),
              let allLogs = try? JSONDecoder().decode([WaterLog].self, from: data) else {
            return []
        }
        let calendar = Calendar.current
        return allLogs.filter { calendar.isDate($0.timestamp, inSameDayAs: date) }
    }
    
    /// Planned meals for the selected date
    private var meals: [PlannedMeal] {
        guard let data = UserDefaults.standard.data(forKey: "plannedMeals"),
              let allMeals = try? JSONDecoder().decode([PlannedMeal].self, from: data) else {
            return []
        }
        let calendar = Calendar.current
        return allMeals.filter { calendar.isDate($0.scheduledTime, inSameDayAs: date) }
            .sorted { $0.scheduledTime < $1.scheduledTime }
    }
    
    /// Total water intake in ml for the date
    private var totalWaterMl: Int {
        waterLogs.reduce(0) { $0 + $1.amountMl }
    }
    
    /// Formatted date string
    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
    
    /// Check if the selected date is today
    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Date header
                    VStack(spacing: 4) {
                        Text(isToday ? "Today" : dateString)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        if !isToday {
                            Text(date.formatted(.dateTime.weekday(.wide)))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 8)
                    
                    // Water intake section
                    if waterStore != nil && !waterLogs.isEmpty {
                        waterSection
                    }
                    
                    // Meals section
                    if mealStore != nil && !meals.isEmpty {
                        mealsSection
                    }
                    
                    // Empty state
                    if waterLogs.isEmpty && meals.isEmpty {
                        emptyState
                    }
                }
                .padding(16)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    /// Water intake summary section
    private var waterSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "drop.fill")
                    .foregroundColor(.blue)
                Text("Water Intake")
                    .font(.headline)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Total:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(totalWaterMl)ml")
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Text("Glasses:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(waterLogs.count)")
                        .fontWeight(.semibold)
                }
                
                Divider()
                
                Text("Logs")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                ForEach(waterLogs.sorted(by: { $0.timestamp > $1.timestamp })) { log in
                    HStack {
                        Text(log.timestamp.formatted(.dateTime.hour().minute()))
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(log.amountMl)ml")
                            .font(.caption)
                    }
                }
            }
            .padding(16)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
        }
    }
    
    /// Meals summary section
    private var mealsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "fork.knife")
                    .foregroundColor(.orange)
                Text("Meals")
                    .font(.headline)
            }
            
            VStack(spacing: 8) {
                ForEach(meals) { meal in
                    HStack(alignment: .top, spacing: 16) {
                        Image(systemName: meal.type.icon)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(meal.type.rawValue)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Text(meal.timeString)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            if let notes = meal.notes, !notes.isEmpty {
                                Text(notes)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                        }
                        
                        Spacer()
                        
                        if meal.isCompleted {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding(16)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
            }
        }
    }
    
    /// Empty state when no data exists
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            
            Text("No Data")
                .font(.headline)
            
            Text("No meals or water intake logged for this day")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 40)
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Day Preview - Today") {
    DayDataPreviewSheet(date: Date.now)
}

#Preview("Day Preview - Past Date") {
    DayDataPreviewSheet(
        date: Calendar.current.date(byAdding: .day, value: -3, to: Date.now)!
    )
}
#endif
