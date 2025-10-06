import Foundation
import Combine

/// Manages active fasting session and historical records
/// Uses `UserDefaults` for persistence in MVP
/// [Rule: Documentation, State Management]
final class FastSessionStore: ObservableObject {
    
    // MARK: - Published State
    
    /// Currently active fasting session if any
    @Published private(set) var activeSession: FastSession?
    
    /// Completed fast sessions stored in reverse chronological order
    @Published private(set) var history: [FastSession]
    
    // MARK: - Storage Keys
    
    private enum StorageKey {
        static let activeSession = "fastSession.active"
        static let history = "fastSession.history"
    }
    
    // MARK: - Initializer
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.activeSession = Self.loadActiveSession(from: userDefaults)
        self.history = Self.loadHistory(from: userDefaults)
    }
    
    // MARK: - Dependencies
    
    private let userDefaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - Session Management
    
    /// Start a new fasting session. Any existing active session will be cancelled.
    /// - Parameter session: `FastSession` to set as active
    func start(session: FastSession) {
        activeSession = session
        persistActiveSession()
    }
    
    /// Complete the current session and move it into history.
    /// - Parameters:
    ///   - completionDate: timestamp when fast completed
    ///   - note: optional note to attach to the finished fast
    func completeActiveSession(at completionDate: Date = Date(), note: String? = nil) {
        guard var session = activeSession else { return }
        session.status = .completed
        session.completionDate = completionDate
        session.note = note
        session.endDate = completionDate
        activeSession = nil
        history.insert(session, at: 0)
        persistActiveSession()
        persistHistory()
    }
    
    /// Cancel the active session without recording history entry.
    func cancelActiveSession() {
        activeSession = nil
        persistActiveSession()
    }
    
    // MARK: - History Utilities
    
    /// Delete a history entry by identifier
    func deleteHistoryEntry(id: UUID) {
        history.removeAll { $0.id == id }
        persistHistory()
    }
    
    /// Clear entire history (useful for debugging or future settings)
    func clearHistory() {
        history.removeAll()
        persistHistory()
    }
    
    // MARK: - Statistics
    
    /// Calculates the total number of completed fasts
    var completedCount: Int {
        history.count
    }
    
    /// Returns the longest fast duration in hours
    var longestFastHours: Double {
        history.map { $0.elapsedSeconds / 3600 }.max() ?? 0
    }
    
    /// Calculates the average fast duration in hours
    var averageFastHours: Double {
        guard !history.isEmpty else { return 0 }
        let totalHours = history.reduce(0) { $0 + ($1.elapsedSeconds / 3600) }
        return totalHours / Double(history.count)
    }
    
    /// Computes the current streak of consecutive completed fasts (simple count for MVP)
    var currentStreak: Int {
        // For MVP we treat any completed fast as part of streak if last completion within 2 days
        guard let latest = history.first?.completionDate else { return 0 }
        var streak = 0
        var previousDate = latest
        for session in history {
            guard let completionDate = session.completionDate else { break }
            let difference = previousDate.timeIntervalSince(completionDate)
            if difference <= 48 * 3600 {
                streak += 1
                previousDate = completionDate
            } else {
                break
            }
        }
        return streak
    }
    
    // MARK: - Persistence
    
    private func persistActiveSession() {
        if let session = activeSession, let data = try? encoder.encode(session) {
            userDefaults.set(data, forKey: StorageKey.activeSession)
        } else {
            userDefaults.removeObject(forKey: StorageKey.activeSession)
        }
    }
    
    private func persistHistory() {
        if let data = try? encoder.encode(history) {
            userDefaults.set(data, forKey: StorageKey.history)
        }
    }
    
    private static func loadActiveSession(from defaults: UserDefaults) -> FastSession? {
        guard let data = defaults.data(forKey: StorageKey.activeSession) else { return nil }
        return try? JSONDecoder().decode(FastSession.self, from: data)
    }
    
    private static func loadHistory(from defaults: UserDefaults) -> [FastSession] {
        guard let data = defaults.data(forKey: StorageKey.history),
              let sessions = try? JSONDecoder().decode([FastSession].self, from: data) else {
            return []
        }
        return sessions.sorted { lhs, rhs in
            let left = lhs.completionDate ?? lhs.startDate
            let right = rhs.completionDate ?? rhs.startDate
            return left > right
        }
    }
}
