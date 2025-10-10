import SwiftUI

/// Sheet for configuring water intake goal and settings
/// [Rule: Documentation, Forms]
struct WaterGoalSettingsSheet: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @State private var dailyGoalGlasses: Int
    @State private var glassSize: Int
    @State private var isReminderEnabled: Bool
    
    let goal: WaterGoal
    let onSave: (WaterGoal) -> Void
    
    private let glassSizeOptions = [200, 250, 300, 350, 500]
    private let dailyGoalOptions = [6, 8, 10, 12, 14]
    
    // MARK: - Initializer
    
    init(goal: WaterGoal, onSave: @escaping (WaterGoal) -> Void) {
        self.goal = goal
        self.onSave = onSave
        _dailyGoalGlasses = State(initialValue: goal.dailyGoalGlasses)
        _glassSize = State(initialValue: goal.glassSize)
        _isReminderEnabled = State(initialValue: goal.isReminderEnabled)
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                // Daily Goal Section
                Section {
                    Picker("Daily Goal", selection: $dailyGoalGlasses) {
                        ForEach(dailyGoalOptions, id: \.self) { count in
                            Text("\(count) glasses").tag(count)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    HStack {
                        Text("Total")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(dailyGoalGlasses * glassSize)ml / \(String(format: "%.1f", Double(dailyGoalGlasses * glassSize) / 1000))L")
                            .foregroundColor(.brandPrimary)
                            .fontWeight(.semibold)
                    }
                } header: {
                    Text("Daily Water Goal")
                } footer: {
                    Text("Recommended: 8 glasses (2 liters) per day")
                }
                
                // Glass Size Section
                Section {
                    Picker("Glass Size", selection: $glassSize) {
                        ForEach(glassSizeOptions, id: \.self) { size in
                            Text("\(size)ml").tag(size)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Glass Size")
                } footer: {
                    Text("Standard glass: 250ml")
                }
                
                // Reminders Section
                Section {
                    Toggle("Enable Reminders", isOn: $isReminderEnabled)
                    
                    if isReminderEnabled {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.brandPrimary)
                            Text("Smart reminders will be distributed throughout your day")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                } header: {
                    Text("Notifications")
                } footer: {
                    Text("Get gentle reminders to stay hydrated")
                }
            }
            .navigationTitle("Water Goal Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveGoal()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
    
    // MARK: - Actions
    
    private func saveGoal() {
        let newGoal = WaterGoal(
            dailyGoalGlasses: dailyGoalGlasses,
            glassSize: glassSize,
            startTime: goal.startTime,
            endTime: goal.endTime,
            isReminderEnabled: isReminderEnabled
        )
        onSave(newGoal)
        dismiss()
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Water Goal Settings") {
    WaterGoalSettingsSheet(goal: .default, onSave: { _ in })
}
#endif
