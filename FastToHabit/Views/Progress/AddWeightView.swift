import SwiftUI

/// Add weight entry view
/// Features: Weight input, date picker, optional note
/// [Rule: Forms, User Input, Data Entry]
struct AddWeightView: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @State private var weight: String = ""
    @State private var date: Date = Date()
    @State private var note: String = ""
    @State private var showingAlert = false
    
    var onSave: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                // Weight Section
                Section {
                    HStack {
                        Image(systemName: "scalemass")
                            .foregroundColor(.brandPrimary)
                            .frame(width: 30)
                        
                        TextField("70.5", text: $weight)
                            .keyboardType(.decimalPad)
                            .font(.bodyRegular)
                        
                        Text("kg")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Weight")
                } footer: {
                    Text("Enter your weight in kilograms")
                }
                
                // Date Section
                Section {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                } header: {
                    Text("Date")
                }
                
                // Note Section (Optional)
                Section {
                    TextField("Optional note", text: $note, axis: .vertical)
                        .lineLimit(3...6)
                } header: {
                    Text("Note (Optional)")
                } footer: {
                    Text("Add any notes about this weight entry")
                }
            }
            .navigationTitle("Add Weight")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveWeight()
                    }
                    .disabled(weight.isEmpty)
                }
            }
            .alert("Weight Added", isPresented: $showingAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Your weight has been recorded successfully")
            }
        }
    }
    
    // MARK: - Actions
    
    /// Save weight entry
    private func saveWeight() {
        guard let weightValue = Double(weight) else { return }
        
        WeightEntryManager.addEntry(
            weight: weightValue,
            note: note.isEmpty ? nil : note
        )
        
        onSave()
        showingAlert = true
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Add Weight View") {
    AddWeightView(onSave: {})
}
#endif
