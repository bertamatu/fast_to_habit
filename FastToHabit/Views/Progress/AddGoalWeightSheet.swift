import SwiftUI

/// Sheet for adding or updating goal weight
/// [Rule: Documentation, Forms]
struct AddGoalWeightSheet: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @State private var goalWeightInput: String
    
    let currentGoalWeight: String
    let onSave: (String) -> Void
    
    // MARK: - Initializer
    
    init(currentGoalWeight: String, onSave: @escaping (String) -> Void) {
        self.currentGoalWeight = currentGoalWeight
        self.onSave = onSave
        _goalWeightInput = State(initialValue: currentGoalWeight)
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Image(systemName: "target")
                            .foregroundColor(.brandPrimary)
                            .frame(width: 30)
                        
                        TextField("70.0", text: $goalWeightInput)
                            .keyboardType(.decimalPad)
                            .font(.bodyRegular)
                        
                        Text("kg")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Goal Weight")
                } footer: {
                    Text("Enter your target weight in kilograms")
                }
            }
            .navigationTitle(currentGoalWeight.isEmpty ? "Set Goal Weight" : "Update Goal Weight")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(goalWeightInput)
                        dismiss()
                    }
                    .disabled(goalWeightInput.isEmpty || Double(goalWeightInput) == nil)
                }
            }
        }
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Add Goal Weight") {
    AddGoalWeightSheet(currentGoalWeight: "", onSave: { _ in })
}

#Preview("Edit Goal Weight") {
    AddGoalWeightSheet(currentGoalWeight: "70.0", onSave: { _ in })
}
#endif
