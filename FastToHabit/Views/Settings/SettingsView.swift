import SwiftUI

/// Settings screen
/// Features: Profile, preferences, notifications, about
/// [Rule: Code Organization, Documentation, User Experience]
struct SettingsView: View {
    
    // MARK: - State
    
    @AppStorage("userHeight") private var height: String = ""
    @AppStorage("userWeight") private var weight: String = ""
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("useMetric") private var useMetric = true
    
    @State private var showingResetAlert = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List {
                // Profile Section
                profileSection
                
                // Preferences Section
                preferencesSection
                
                // Notifications Section
                notificationsSection
                
                // About Section
                aboutSection
                
                // Reset Section
                resetSection
            }
            .navigationTitle("Settings")
        }
    }
    
    // MARK: - Sections
    
    /// Profile section with height and weight
    private var profileSection: some View {
        Section {
            HStack {
                Label("Height", systemImage: "ruler")
                    .foregroundColor(.primary)
                Spacer()
                Text(height.isEmpty ? "Not set" : "\(height) cm")
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Label("Weight", systemImage: "scalemass")
                    .foregroundColor(.primary)
                Spacer()
                Text(weight.isEmpty ? "Not set" : "\(weight) kg")
                    .foregroundColor(.secondary)
            }
        } header: {
            Text("Profile")
        } footer: {
            Text("Your height and weight help track your progress")
        }
    }
    
    /// Preferences section
    private var preferencesSection: some View {
        Section {
            Toggle(isOn: $useMetric) {
                Label("Metric Units", systemImage: "ruler.fill")
                    .foregroundColor(.primary)
            }
            .tint(.brandPrimary)
            
            HStack {
                Label("App Theme", systemImage: "paintbrush.fill")
                    .foregroundColor(.primary)
                Spacer()
                Text("System")
                    .foregroundColor(.secondary)
            }
        } header: {
            Text("Preferences")
        } footer: {
            Text("Metric units use cm and kg, imperial uses ft and lbs")
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
        UserDefaults.standard.removeObject(forKey: "userHeight")
        UserDefaults.standard.removeObject(forKey: "userWeight")
        
        // Reset state
        height = ""
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
