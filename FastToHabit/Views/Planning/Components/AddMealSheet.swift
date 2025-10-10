import SwiftUI

/// Sheet for adding or editing a planned meal
/// [Rule: Documentation, Forms]
struct AddMealSheet: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedType: MealType
    @State private var scheduledTime: Date
    @State private var notes: String
    
    let meal: PlannedMeal?
    let onSave: (MealType, Date, String?) -> Void
    
    // MARK: - Initializer
    
    init(meal: PlannedMeal? = nil, onSave: @escaping (MealType, Date, String?) -> Void) {
        self.meal = meal
        self.onSave = onSave
        
        // Initialize state from existing meal or defaults
        _selectedType = State(initialValue: meal?.type ?? .breakfast)
        _scheduledTime = State(initialValue: meal?.scheduledTime ?? Date())
        _notes = State(initialValue: meal?.notes ?? "")
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                // Meal Type Section
                Section {
                    Picker("Meal Type", selection: $selectedType) {
                        ForEach(MealType.allCases) { type in
                            HStack {
                                Image(systemName: type.icon)
                                Text(type.rawValue)
                            }
                            .tag(type)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Type")
                }
                
                // Time Section
                Section {
                    DatePicker(
                        "Scheduled Time",
                        selection: $scheduledTime,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.compact)
                } header: {
                    Text("Time")
                } footer: {
                    Text("Set when you plan to have this meal")
                }
                
                // Notes Section (Optional)
                Section {
                    TextField("Optional notes", text: $notes, axis: .vertical)
                        .lineLimit(2...4)
                } header: {
                    Text("Notes (Optional)")
                } footer: {
                    Text("Add any details about this meal")
                }
            }
            .navigationTitle(meal == nil ? "Add Meal" : "Edit Meal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveMeal()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
    
    // MARK: - Actions
    
    private func saveMeal() {
        let finalNotes = notes.isEmpty ? nil : notes
        onSave(selectedType, scheduledTime, finalNotes)
        dismiss()
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Add Meal") {
    AddMealSheet(onSave: { _, _, _ in })
}

#Preview("Edit Meal") {
    let meal = PlannedMeal(
        type: .lunch,
        scheduledTime: Date(),
        notes: "Salad with chicken"
    )
    AddMealSheet(meal: meal, onSave: { _, _, _ in })
}
#endif
