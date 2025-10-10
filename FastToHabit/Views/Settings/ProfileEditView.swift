import SwiftUI

/// Profile edit view for height and weight
/// Features: Editable forms, validation, save/cancel
/// [Rule: Code Organization, User Experience, Form Validation]
struct ProfileEditView: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("userWeight") private var savedWeight: String = ""
    @AppStorage("userGoalWeight") private var savedGoalWeight: String = ""
    
    @State private var weight: String = ""
    @State private var goalWeight: String = ""
    @State private var showingSaveAlert = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                // Current Weight Section
                Section {
                    HStack {
                        Image(systemName: "scalemass")
                            .foregroundColor(.brandPrimary)
                            .frame(width: 30)
                        
                        TextField("70", text: $weight)
                            .keyboardType(.decimalPad)
                            .font(.bodyRegular)
                        
                        Text("kg")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Current Weight")
                } footer: {
                    Text("Enter your current weight in kilograms")
                }
                
                // Goal Weight Section
                Section {
                    HStack {
                        Image(systemName: "target")
                            .foregroundColor(.brandSecondary)
                            .frame(width: 30)
                        
                        TextField("65", text: $goalWeight)
                            .keyboardType(.decimalPad)
                            .font(.bodyRegular)
                        
                        Text("kg")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Goal Weight")
                } footer: {
                    Text("Enter your target weight goal")
                }
                
                // Info Section
                Section {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.brandAccent)
                        Text("Track your weight progress towards your goal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveProfile()
                    }
                    .disabled(!isValid)
                }
            }
            .onAppear {
                // Load existing values
                weight = savedWeight
                goalWeight = savedGoalWeight
            }
            .alert("Profile Saved", isPresented: $showingSaveAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Your profile has been updated successfully")
            }
        }
    }
    
    // MARK: - Validation
    
    /// Check if form is valid
    private var isValid: Bool {
        // At least one field should be filled
        !weight.isEmpty || !goalWeight.isEmpty
    }
    
    // MARK: - Actions
    
    /// Save profile data
    private func saveProfile() {
        savedWeight = weight
        savedGoalWeight = goalWeight
        showingSaveAlert = true
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Profile Edit View") {
    ProfileEditView()
}

#Preview("Profile Edit View - Dark") {
    ProfileEditView()
        .preferredColorScheme(.dark)
}
#endif
