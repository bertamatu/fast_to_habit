import SwiftUI

/// Profile edit view for height and weight
/// Features: Editable forms, validation, save/cancel
/// [Rule: Code Organization, User Experience, Form Validation]
struct ProfileEditView: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("userWeight") private var savedWeight: String = ""
    
    @State private var weight: String = ""
    @State private var showingSaveAlert = false
    
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
                        
                        TextField("70", text: $weight)
                            .keyboardType(.decimalPad)
                            .font(.bodyRegular)
                        
                        Text("kg")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("Weight")
                } footer: {
                    Text("Enter your current weight in kilograms")
                }
                
                // Info Section
                Section {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.brandAccent)
                        Text("Your weight helps us track your progress over time")
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
                // Load existing value
                weight = savedWeight
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
        // Weight should be filled
        !weight.isEmpty
    }
    
    // MARK: - Actions
    
    /// Save profile data
    private func saveProfile() {
        savedWeight = weight
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
