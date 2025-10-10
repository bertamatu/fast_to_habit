import Foundation

/// Model representing a single water intake log entry
/// [Rule: Documentation, State Management]
struct WaterLog: Identifiable, Codable {
    let id: UUID
    let timestamp: Date
    let amountMl: Int
    
    init(id: UUID = UUID(), timestamp: Date = Date(), amountMl: Int) {
        self.id = id
        self.timestamp = timestamp
        self.amountMl = amountMl
    }
}

/// Model representing daily water intake goal and settings
/// [Rule: Documentation, State Management]
struct WaterGoal: Codable {
    var dailyGoalGlasses: Int
    var glassSize: Int // ml
    var startTime: Date // Time of day when reminders start
    var endTime: Date // Time of day when reminders end
    var isReminderEnabled: Bool
    
    /// Total daily goal in milliliters
    var dailyGoalMl: Int {
        dailyGoalGlasses * glassSize
    }
    
    /// Default water goal configuration
    static var `default`: WaterGoal {
        let calendar = Calendar.current
        let now = Date()
        
        // Default start: 7 AM
        let start = calendar.date(bySettingHour: 7, minute: 0, second: 0, of: now) ?? now
        // Default end: 11 PM
        let end = calendar.date(bySettingHour: 23, minute: 0, second: 0, of: now) ?? now
        
        return WaterGoal(
            dailyGoalGlasses: 8,
            glassSize: 250, // 250ml standard glass
            startTime: start,
            endTime: end,
            isReminderEnabled: true
        )
    }
}

/// Manager for water intake tracking and persistence
/// [Rule: Documentation, State Management]
@Observable
final class WaterIntakeStore {
    
    // MARK: - Properties
    
    private(set) var todayLogs: [WaterLog] = []
    var goal: WaterGoal
    
    private let logsKey = "waterLogs"
    private let goalKey = "waterGoal"
    
    // MARK: - Computed Properties
    
    /// Total water consumed today in milliliters
    var todayTotalMl: Int {
        todayLogs.reduce(0) { $0 + $1.amountMl }
    }
    
    /// Number of glasses consumed today
    var todayGlassesCount: Int {
        todayLogs.count
    }
    
    /// Progress toward daily goal (0.0 to 1.0)
    var progress: Double {
        guard goal.dailyGoalMl > 0 else { return 0 }
        return min(Double(todayTotalMl) / Double(goal.dailyGoalMl), 1.0)
    }
    
    /// Whether daily goal has been reached
    var isGoalReached: Bool {
        todayTotalMl >= goal.dailyGoalMl
    }
    
    /// Remaining glasses to reach goal
    var remainingGlasses: Int {
        max(goal.dailyGoalGlasses - todayGlassesCount, 0)
    }
    
    // MARK: - Initialization
    
    init() {
        self.goal = Self.loadGoal()
        self.todayLogs = Self.loadTodayLogs()
    }
    
    // MARK: - Public Methods
    
    /// Log a glass of water
    func logWater(amountMl: Int? = nil) {
        let amount = amountMl ?? goal.glassSize
        let log = WaterLog(timestamp: Date(), amountMl: amount)
        todayLogs.append(log)
        saveLogs()
    }
    
    /// Remove the most recent water log
    func undoLastLog() {
        guard !todayLogs.isEmpty else { return }
        todayLogs.removeLast()
        saveLogs()
    }
    
    /// Update water goal settings
    func updateGoal(_ newGoal: WaterGoal) {
        goal = newGoal
        saveGoal()
    }
    
    /// Clear today's logs (for testing or reset)
    func clearTodayLogs() {
        todayLogs.removeAll()
        saveLogs()
    }
    
    // MARK: - Private Methods
    
    private func saveLogs() {
        let allLogs = Self.loadAllLogs()
        let calendar = Calendar.current
        
        // Filter out old today's logs and add current
        let otherDaysLogs = allLogs.filter { log in
            !calendar.isDateInToday(log.timestamp)
        }
        
        let combined = otherDaysLogs + todayLogs
        
        if let encoded = try? JSONEncoder().encode(combined) {
            UserDefaults.standard.set(encoded, forKey: logsKey)
        }
    }
    
    private func saveGoal() {
        if let encoded = try? JSONEncoder().encode(goal) {
            UserDefaults.standard.set(encoded, forKey: goalKey)
        }
    }
    
    private static func loadAllLogs() -> [WaterLog] {
        guard let data = UserDefaults.standard.data(forKey: "waterLogs"),
              let logs = try? JSONDecoder().decode([WaterLog].self, from: data) else {
            return []
        }
        return logs
    }
    
    private static func loadTodayLogs() -> [WaterLog] {
        let allLogs = loadAllLogs()
        let calendar = Calendar.current
        return allLogs.filter { calendar.isDateInToday($0.timestamp) }
    }
    
    private static func loadGoal() -> WaterGoal {
        guard let data = UserDefaults.standard.data(forKey: "waterGoal"),
              let goal = try? JSONDecoder().decode(WaterGoal.self, from: data) else {
            return .default
        }
        return goal
    }
}
