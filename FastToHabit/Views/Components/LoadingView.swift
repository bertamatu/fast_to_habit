import SwiftUI

/// Loading view component with optional message
/// Features: Spinner, message, overlay mode
/// [Rule: Component Library, Documentation]
struct LoadingView: View {
    
    // MARK: - Properties
    
    /// Optional loading message
    var message: String? = nil
    
    /// Whether to show as full-screen overlay
    var isOverlay: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        if isOverlay {
            overlayView
        } else {
            contentView
        }
    }
    
    // MARK: - Subviews
    
    /// Content view with spinner and message
    private var contentView: some View {
        VStack(spacing: Constants.Spacing.medium) {
            ProgressView()
                .scaleEffect(1.2)
                .progressViewStyle(CircularProgressViewStyle(tint: .brandPrimary))
            
            if let message = message {
                Text(message)
                    .font(.bodySmall)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    /// Overlay view with semi-transparent background
    private var overlayView: some View {
        ZStack {
            // Semi-transparent background
            Color.black
                .opacity(Constants.Opacity.overlay)
                .ignoresSafeArea()
            
            // Loading card
            VStack(spacing: Constants.Spacing.medium) {
                ProgressView()
                    .scaleEffect(1.2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .brandPrimary))
                
                if let message = message {
                    Text(message)
                        .font(.bodySmall)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(Constants.Spacing.extraLarge)
            .background(
                RoundedRectangle(cornerRadius: Constants.CornerRadius.medium)
                    .fill(Color.cardBackground)
            )
            .shadow(radius: Constants.Shadow.radius)
        }
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Loading View Variants") {
    VStack(spacing: 40) {
        // Simple loading
        LoadingView()
            .frame(height: 100)
        
        Divider()
        
        // Loading with message
        LoadingView(message: "Loading your fasting data...")
            .frame(height: 150)
        
        Divider()
        
        // Overlay mode
        ZStack {
            // Background content
            VStack {
                Text("Background Content")
                    .font(.titleLarge)
                Image(systemName: "clock")
                    .font(.system(size: 60))
            }
            
            // Loading overlay
            LoadingView(message: "Saving...", isOverlay: true)
        }
        .frame(height: 300)
    }
}

#Preview("Loading Overlay Example") {
    ZStack {
        // Simulated app content
        ScrollView {
            VStack(spacing: Constants.Spacing.medium) {
                ForEach(0..<5) { index in
                    Card(title: "Item \(index + 1)") {
                        Text("Some content here")
                            .font(.bodyRegular)
                    }
                }
            }
            .padding(Constants.Spacing.large)
        }
        
        // Loading overlay
        LoadingView(message: "Syncing your data...", isOverlay: true)
    }
}

#Preview("Loading Dark Mode") {
    VStack(spacing: 40) {
        LoadingView()
            .frame(height: 100)
        
        LoadingView(message: "Loading...")
            .frame(height: 150)
        
        ZStack {
            Color.black
            LoadingView(message: "Saving...", isOverlay: true)
        }
        .frame(height: 300)
    }
    .preferredColorScheme(.dark)
}
#endif
