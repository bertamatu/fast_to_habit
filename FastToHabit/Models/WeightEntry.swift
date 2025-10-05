import Foundation

/// Weight entry model for tracking weight over time
/// [Rule: Data Models, Documentation]
struct WeightEntry: Codable, Identifiable {
    let id: UUID
    let weight: Double
    let date: Date
    let note: String?
    
    init(id: UUID = UUID(), weight: Double, date: Date = Date(), note: String? = nil) {
        self.id = id
        self.weight = weight
        self.date = date
        self.note = note
    }
}

/// Weight entry manager for persistence
/// [Rule: Data Management, Persistence]
class WeightEntryManager {
    private static let storageKey = "weightEntries"
    
    /// Save weight entries to UserDefaults
    static func saveEntries(_ entries: [WeightEntry]) {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    /// Load weight entries from UserDefaults
    static func loadEntries() -> [WeightEntry] {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let entries = try? JSONDecoder().decode([WeightEntry].self, from: data) else {
            return []
        }
        return entries.sorted { $0.date > $1.date } // Most recent first
    }
    
    /// Add a new weight entry
    static func addEntry(weight: Double, note: String? = nil) {
        var entries = loadEntries()
        let newEntry = WeightEntry(weight: weight, note: note)
        entries.append(newEntry)
        saveEntries(entries)
        
        // Update current weight in UserDefaults
        UserDefaults.standard.set(String(weight), forKey: "userWeight")
    }
    
    /// Delete a weight entry
    static func deleteEntry(id: UUID) {
        var entries = loadEntries()
        entries.removeAll { $0.id == id }
        saveEntries(entries)
    }
}
