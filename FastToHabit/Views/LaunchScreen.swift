import SwiftUI

/// Launch screen view for Fast To Habit
/// Features: App logo, brand colors, smooth fade-in animation
/// [Rule: Design System, Launch Screen, Animations]
struct LaunchScreen: View {
    
    // MARK: - State
    
    @State private var isAnimating = false
    @State private var showContent = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Clean background - white in light mode, black in dark mode
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            // Content
            VStack(spacing: Constants.Spacing.extraLarge) {
                // App icon/logo
                if let logoImage = UIImage(named: "LaunchLogoCircle") {
                    Image(uiImage: logoImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .scaleEffect(isAnimating ? 1.0 : 0.85)
                        .opacity(isAnimating ? 1.0 : 0.0)
                } else {
                    // Fallback icon if image not found
                    ZStack {
                        Circle()
                            .fill(Color.brandPrimary.opacity(0.1))
                            .frame(width: 140, height: 140)
                        
                        Image(systemName: "clock.fill")
                            .font(.system(size: 70))
                            .foregroundColor(.brandPrimary)
                    }
                    .scaleEffect(isAnimating ? 1.0 : 0.85)
                    .opacity(isAnimating ? 1.0 : 0.0)
                }
                
                // App name (optional - can be removed for even cleaner look)
                if showContent {
                    VStack(spacing: Constants.Spacing.small) {
                        Text("Fast To Habit")
                            .font(.titleMedium)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Text("Track • Fast • Thrive")
                            .font(.bodySmall)
                            .foregroundColor(.secondary)
                    }
                    .opacity(isAnimating ? 1.0 : 0.0)
                }
            }
        }
        .onAppear {
            // Smooth fade-in animation
            withAnimation(.easeOut(duration: 0.6).delay(0.1)) {
                isAnimating = true
            }
            
            // Show text after logo animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.easeOut(duration: 0.5)) {
                    showContent = true
                }
            }
        }
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Launch Screen") {
    LaunchScreen()
}

#Preview("Launch Screen - Dark") {
    LaunchScreen()
        .preferredColorScheme(.dark)
}
#endif
