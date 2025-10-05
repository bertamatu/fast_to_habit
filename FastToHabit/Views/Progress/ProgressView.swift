import SwiftUI

/// Progress tracking screen
/// Features: Weight tracking, fasting history, statistics
/// [Rule: Code Organization, Documentation]
struct ProgressView: View {
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                // Placeholder content
                VStack(spacing: Constants.Spacing.large) {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .font(.system(size: Constants.IconSize.extraLarge))
                        .foregroundColor(.brandAccent)
                    
                    Text("Progress")
                        .font(.titleLarge)
                        .foregroundColor(.primary)
                    
                    Text("Track your health journey")
                        .font(.bodyRegular)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Progress")
        }
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Progress View") {
    ProgressView()
}

#Preview("Progress View - Dark") {
    ProgressView()
        .preferredColorScheme(.dark)
}
#endif
