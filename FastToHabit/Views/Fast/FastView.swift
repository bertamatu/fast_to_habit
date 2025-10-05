import SwiftUI

/// Fasting timer main screen
/// Features: Timer, start/stop, progress tracking
/// [Rule: Code Organization, Documentation]
struct FastView: View {
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                // Placeholder content
                VStack(spacing: Constants.Spacing.large) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: Constants.IconSize.extraLarge))
                        .foregroundColor(.brandPrimary)
                    
                    Text("Fasting Timer")
                        .font(.titleLarge)
                        .foregroundColor(.primary)
                    
                    Text("Track your fasting journey")
                        .font(.bodyRegular)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Fast")
        }
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Fast View") {
    FastView()
}

#Preview("Fast View - Dark") {
    FastView()
        .preferredColorScheme(.dark)
}
#endif
