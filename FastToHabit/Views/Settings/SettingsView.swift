import SwiftUI

/// Settings screen
/// Features: App preferences, profile, notifications, about
/// [Rule: Code Organization, Documentation]
struct SettingsView: View {
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                // Placeholder content
                VStack(spacing: Constants.Spacing.large) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: Constants.IconSize.extraLarge))
                        .foregroundColor(.secondary)
                    
                    Text("Settings")
                        .font(.titleLarge)
                        .foregroundColor(.primary)
                    
                    Text("Customize your experience")
                        .font(.bodyRegular)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
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
