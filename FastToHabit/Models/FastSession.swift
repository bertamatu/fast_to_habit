import Foundation

/// Preset fasting durations supported by the app
/// [Rule: Documentation]
enum FastPreset: String, Codable, CaseIterable, Equatable {
  case twelveTwelve = "12:12"
    case fourteenTen = "14:10"
    case sixteenEight = "16:8"
    case eighteenSix = "18:6"
    case twentyFour = "20:4"
    case omad = "OMAD"
    case custom = "Custom"
    
    /// Duration of the fasting window in hours for presets
    /// Custom presets rely on the session's `goalDurationHours` property
    var defaultDurationHours: Double {
        switch self {
        case .twelveTwelve:
            return 12
        case .fourteenTen:
            return 14
        case .sixteenEight:
            return 16
        case .eighteenSix:
            return 18
        case .twentyFour:
            return 20
        case .omad:
            return 24
        case .custom:
            return 0
        }
    }
    
    /// Human-friendly name for display purposes
    var displayName: String {
        rawValue
    }

    /// Short descriptor communicating the fasting level
    var tagline: String {
        switch self {
        case .twelveTwelve:
            return "Beginner"
        case .fourteenTen:
            return "Balanced"
        case .sixteenEight:
            return "Intermediate"
        case .eighteenSix:
            return "Advanced"
        case .twentyFour:
            return "Warrior"
        case .omad:
            return "Expert"
        case .custom:
            return "Custom"
        }
    }

    /// Suggested duration hours for display (falls back to custom duration)
    var suggestedDurationHours: Double {
        defaultDurationHours
    }
}

/// Represents a single fasting session, active or completed
/// [Rule: Documentation]
struct FastSession: Codable, Identifiable, Equatable {
    
    // MARK: - Nested Types
    
    /// Status of a fasting session lifecycle
    enum Status: String, Codable {
        case active
        case completed
        case cancelled
    }
    
    // MARK: - Properties
    
    /// Unique identifier for the session
    let id: UUID
    
    /// Preset duration type used to start the fast
    let preset: FastPreset
    
    /// Timestamp when the fast started
    let startDate: Date
    
    /// Goal duration in hours for the fast
    /// For custom fasts this value is set manually
    let goalDurationHours: Double
    
    /// Optional timestamp when the fast ended or is scheduled to end
    var endDate: Date?
    
    /// Current status of the fast
    var status: Status
    
    /// Optional user-provided note about the session
    var note: String?
    
    /// Timestamp when the fast was marked as completed
    var completionDate: Date?
    
    // MARK: - Initializer
    
    /// Initializes a new fasting session instance
    /// - Parameters:
    ///   - id: Unique identifier with default value
    ///   - preset: Selected preset for the fast
    ///   - startDate: Start timestamp for the fast
    ///   - goalDurationHours: Target fasting duration in hours
    ///   - endDate: Scheduled end time if already known
    ///   - status: Initial status, defaults to `.active`
    ///   - note: Optional note for the session
    ///   - completionDate: Timestamp of completion when applicable
    init(
        id: UUID = UUID(),
        preset: FastPreset,
        startDate: Date = Date(),
        goalDurationHours: Double,
        endDate: Date? = nil,
        status: Status = .active,
        note: String? = nil,
        completionDate: Date? = nil
    ) {
        self.id = id
        self.preset = preset
        self.startDate = startDate
        self.goalDurationHours = goalDurationHours
        self.endDate = endDate
        self.status = status
        self.note = note
        self.completionDate = completionDate
    }
    
    // MARK: - Computed Properties
    
    /// Expected end date based on start date and goal duration if not already set
    var expectedEndDate: Date {
        if let endDate {
            return endDate
        }
        return startDate.addingTimeInterval(goalDurationHours * 3600)
    }
    
    /// Elapsed time in seconds from the start date to now or the recorded completion date
    var elapsedSeconds: TimeInterval {
        let referenceEnd = completionDate ?? Date()
        return referenceEnd.timeIntervalSince(startDate)
    }
    
    /// Progress ratio (0.0 - 1.0+) based on elapsed time versus goal duration
    var progress: Double {
        guard goalDurationHours > 0 else { return 0 }
        let goalSeconds = goalDurationHours * 3600
        return min(elapsedSeconds / goalSeconds, 1.0)
    }
}
