import SwiftUI

/// Primary button component for main CTAs
/// Features: Loading state, disabled state, haptic feedback, accessibility
/// [Rule: Component Library, Documentation, Accessibility]
struct PrimaryButton: View {
    
    // MARK: - Properties
    
    /// Button title text
    let title: String
    
    /// Action to perform when button is tapped
    let action: () -> Void
    
    /// Whether the button is in loading state
    var isLoading: Bool = false
    
    /// Whether the button is disabled
    var isDisabled: Bool = false
    
    /// Optional SF Symbol icon name
    var icon: String? = nil
    
    /// Button style variant
    var style: ButtonStyle = .filled
    
    // MARK: - Private State
    
    @State private var isPressed: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        Button(action: handleTap) {
            HStack(spacing: Constants.Spacing.small) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: Constants.IconSize.small, weight: .semibold))
                    }
                    
                    Text(title)
                        .font(.button)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: Constants.Button.height)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(Constants.CornerRadius.medium)
            .opacity(opacity)
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(Constants.Animation.quick, value: isPressed)
        }
        .disabled(isDisabled || isLoading)
        .accessibilityLabel(title)
        .accessibilityHint(isLoading ? "Loading" : "")
        .accessibilityAddTraits(isDisabled ? .isButton : [.isButton])
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
    
    // MARK: - Helpers
    
    /// Handle button tap with haptic feedback
    private func handleTap() {
        // Haptic feedback
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
        
        // Perform action
        action()
    }
    
    /// Foreground color based on state and style
    private var foregroundColor: Color {
        switch style {
        case .filled:
            return .white
        case .outlined:
            return isDisabled ? .gray : .brandPrimary
        }
    }
    
    /// Background color based on state and style
    private var backgroundColor: Color {
        switch style {
        case .filled:
            return isDisabled ? .gray : .brandPrimary
        case .outlined:
            return .clear
        }
    }
    
    /// Opacity based on state
    private var opacity: Double {
        if isDisabled {
            return Constants.Opacity.disabled
        } else if isPressed {
            return Constants.Opacity.pressed
        } else {
            return 1.0
        }
    }
}

// MARK: - Button Style

extension PrimaryButton {
    enum ButtonStyle {
        case filled
        case outlined
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Primary Button States") {
    VStack(spacing: Constants.Spacing.medium) {
        // Normal state
        PrimaryButton(title: "Start Fasting", action: {})
        
        // With icon
        PrimaryButton(title: "Start Fasting", action: {}, icon: "play.fill")
        
        // Loading state
        PrimaryButton(title: "Loading", action: {}, isLoading: true)
        
        // Disabled state
        PrimaryButton(title: "Disabled", action: {}, isDisabled: true)
        
        // Outlined style
        PrimaryButton(title: "Secondary Action", action: {}, style: .outlined)
    }
    .padding(Constants.Spacing.large)
}

#Preview("Primary Button Dark Mode") {
    VStack(spacing: Constants.Spacing.medium) {
        PrimaryButton(title: "Start Fasting", action: {})
        PrimaryButton(title: "With Icon", action: {}, icon: "play.fill")
        PrimaryButton(title: "Loading", action: {}, isLoading: true)
    }
    .padding(Constants.Spacing.large)
    .preferredColorScheme(.dark)
}
#endif
