import SwiftUI

/// Settings screen
/// Features: Profile, preferences, notifications, about
/// [Rule: Code Organization, Documentation, User Experience]
struct SettingsView: View {
    
    // MARK: - State
    
    @AppStorage("userWeight") private var weight: String = ""
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("useMetric") private var useMetric = true
    
    @State private var showingResetAlert = false
    @State private var showingProfileEdit = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List {
                // Profile Section
                profileSection
                
                // Units Section
                unitsSection
                
                // Theme Section
                themeSection
                
                // Notifications Section
                notificationsSection
                
                // About Section
                aboutSection
                
                // Reset Section
                resetSection
            }
            .navigationTitle("Settings")
        }
        .sheet(isPresented: $showingProfileEdit) {
            ProfileEditView()
        }
    }
    
    // MARK: - Sections
    
    /// Profile section with weight
    private var profileSection: some View {
        Section {
            Button {
                showingProfileEdit = true
            } label: {
                HStack {
                    Label("Weight", systemImage: "scalemass")
                        .foregroundColor(.primary)
                    Spacer()
                    Text(weight.isEmpty ? "Not set" : "\(weight) kg")
                        .foregroundColor(.secondary)
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        } header: {
            Text("Profile")
        } footer: {
            Text("Tap to edit your weight for progress tracking")
        }
    }
    
    /// Units section
    private var unitsSection: some View {
        Section {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Label("Units", systemImage: "ruler.fill")
                        .foregroundColor(.primary)
                    
                    Text(useMetric ? "kg, cm" : "lbs, ft")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Toggle("", isOn: $useMetric)
                    .labelsHidden()
                    .tint(.brandPrimary)
            }
        } header: {
            Text("Units")
        } footer: {
            Text(useMetric ? "Using metric system (kg, cm)" : "Using imperial system (lbs, ft)")
        }
    }
    
    /// Theme section
    private var themeSection: some View {
        Section {
            HStack {
                Label("App Theme", systemImage: "paintbrush.fill")
                    .foregroundColor(.primary)
                Spacer()
                Text("System")
                    .foregroundColor(.secondary)
            }
        } header: {
            Text("Appearance")
        } footer: {
            Text("App theme follows your device settings")
        }
    }
    
    /// Notifications section
    private var notificationsSection: some View {
        Section {
            Toggle(isOn: $notificationsEnabled) {
                Label("Notifications", systemImage: "bell.fill")
                    .foregroundColor(.primary)
            }
            .tint(.brandPrimary)
            
            if notificationsEnabled {
                HStack {
                    Label("Fasting Reminders", systemImage: "clock")
                        .foregroundColor(.primary)
                    Spacer()
                    Text("Enabled")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Label("Supplement Reminders", systemImage: "pills")
                        .foregroundColor(.primary)
                    Spacer()
                    Text("Enabled")
                        .foregroundColor(.secondary)
                }
            }
        } header: {
            Text("Notifications")
        } footer: {
            Text("Get reminders for fasting and supplements")
        }
    }
    
    /// About section
    private var aboutSection: some View {
        Section {
            HStack {
                Label("Version", systemImage: "info.circle")
                    .foregroundColor(.primary)
                Spacer()
                Text(Constants.App.version)
                    .foregroundColor(.secondary)
            }
            
            Button {
                // Open privacy policy
            } label: {
                Label("Privacy Policy", systemImage: "hand.raised.fill")
                    .foregroundColor(.primary)
            }
            
            Button {
                // Open terms
            } label: {
                Label("Terms of Service", systemImage: "doc.text")
                    .foregroundColor(.primary)
            }
            
            Button {
                // Open support
            } label: {
                Label("Support", systemImage: "questionmark.circle")
                    .foregroundColor(.primary)
            }
        } header: {
            Text("About")
        }
    }
    
    /// Reset section
    private var resetSection: some View {
        Section {
            Button(role: .destructive) {
                showingResetAlert = true
            } label: {
                Label("Reset All Data", systemImage: "trash")
            }
        } footer: {
            Text("This will delete all your data and reset the app")
        }
        .alert("Reset All Data?", isPresented: $showingResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                resetAllData()
            }
        } message: {
            Text("This will delete all your data and cannot be undone.")
        }
    }
    
    // MARK: - Actions
    
    /// Reset all app data
    private func resetAllData() {
        // Clear UserDefaults
        UserDefaults.standard.removeObject(forKey: "hasCompletedOnboarding")
        UserDefaults.standard.removeObject(forKey: "userWeight")
        
        // Reset state
        weight = ""
        
        // App will restart to onboarding
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Settings View") {
    SettingsView()
}

#Preview("Settings View - Dark") {
    SettingsView()
        .preferredColorScheme(.dark)
}
#endif
