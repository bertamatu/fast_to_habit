import Foundation

/// Meal type options
/// [Rule: Documentation]
enum MealType: String, Codable, CaseIterable, Identifiable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
    
    var id: String { rawValue }
    
    /// Icon for each meal type
    var icon: String {
        switch self {
        case .breakfast: return "sunrise.fill"
        case .lunch: return "sun.max.fill"
        case .dinner: return "moon.stars.fill"
        case .snack: return "leaf.fill"
        }
    }
}

/// Model representing a planned meal
/// [Rule: Documentation, State Management]
struct PlannedMeal: Identifiable, Codable {
    let id: UUID
    var type: MealType
    var scheduledTime: Date
    var notes: String?
    var isCompleted: Bool
    
    init(
        id: UUID = UUID(),
        type: MealType,
        scheduledTime: Date,
        notes: String? = nil,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.type = type
        self.scheduledTime = scheduledTime
        self.notes = notes
        self.isCompleted = isCompleted
    }
    
    /// Formatted time string (e.g., "12:00 PM")
    var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: scheduledTime)
    }
}

/// Manager for meal planning and persistence
/// [Rule: Documentation, State Management]
@Observable
final class MealPlanStore {
    
    // MARK: - Properties
    
    private(set) var todayMeals: [PlannedMeal] = []
    
    private let mealsKey = "plannedMeals"
    
    // MARK: - Computed Properties
    
    /// Number of completed meals today
    var completedCount: Int {
        todayMeals.filter { $0.isCompleted }.count
    }
    
    /// Number of planned meals today
    var totalCount: Int {
        todayMeals.count
    }
    
    /// Meals sorted by scheduled time
    var sortedMeals: [PlannedMeal] {
        todayMeals.sorted { $0.scheduledTime < $1.scheduledTime }
    }
    
    // MARK: - Initialization
    
    init() {
        self.todayMeals = Self.loadTodayMeals()
    }
    
    // MARK: - Public Methods
    
    /// Add a new planned meal
    func addMeal(type: MealType, scheduledTime: Date, notes: String? = nil) {
        let meal = PlannedMeal(
            type: type,
            scheduledTime: scheduledTime,
            notes: notes
        )
        todayMeals.append(meal)
        saveMeals()
    }
    
    /// Toggle meal completion status
    func toggleCompletion(for mealId: UUID) {
        guard let index = todayMeals.firstIndex(where: { $0.id == mealId }) else { return }
        todayMeals[index].isCompleted.toggle()
        saveMeals()
    }
    
    /// Update an existing meal
    func updateMeal(_ meal: PlannedMeal) {
        guard let index = todayMeals.firstIndex(where: { $0.id == meal.id }) else { return }
        todayMeals[index] = meal
        saveMeals()
    }
    
    /// Delete a meal
    func deleteMeal(at offsets: IndexSet) {
        let sorted = sortedMeals
        offsets.forEach { index in
            if let mealToDelete = sorted[safe: index],
               let actualIndex = todayMeals.firstIndex(where: { $0.id == mealToDelete.id }) {
                todayMeals.remove(at: actualIndex)
            }
        }
        saveMeals()
    }
    
    /// Clear all meals (for testing or reset)
    func clearAllMeals() {
        todayMeals.removeAll()
        saveMeals()
    }
    
    // MARK: - Private Methods
    
    private func saveMeals() {
        let allMeals = Self.loadAllMeals()
        let calendar = Calendar.current
        
        // Filter out old today's meals and add current
        let otherDaysMeals = allMeals.filter { meal in
            !calendar.isDateInToday(meal.scheduledTime)
        }
        
        let combined = otherDaysMeals + todayMeals
        
        if let encoded = try? JSONEncoder().encode(combined) {
            UserDefaults.standard.set(encoded, forKey: mealsKey)
        }
    }
    
    private static func loadAllMeals() -> [PlannedMeal] {
        guard let data = UserDefaults.standard.data(forKey: "plannedMeals"),
              let meals = try? JSONDecoder().decode([PlannedMeal].self, from: data) else {
            return []
        }
        return meals
    }
    
    private static func loadTodayMeals() -> [PlannedMeal] {
        let allMeals = loadAllMeals()
        let calendar = Calendar.current
        return allMeals.filter { calendar.isDateInToday($0.scheduledTime) }
    }
}

// MARK: - Array Extension

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
