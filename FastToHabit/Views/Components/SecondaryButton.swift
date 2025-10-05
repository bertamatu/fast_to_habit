import SwiftUI

/// Secondary button component for less prominent actions
/// Features: Outlined style, haptic feedback, accessibility
/// [Rule: Component Library, Documentation, Accessibility]
struct SecondaryButton: View {
    
    // MARK: - Properties
    
    /// Button title text
    let title: String
    
    /// Action to perform when button is tapped
    let action: () -> Void
    
    /// Whether the button is disabled
    var isDisabled: Bool = false
    
    /// Optional SF Symbol icon name
    var icon: String? = nil
    
    // MARK: - Private State
    
    @State private var isPressed: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        Button(action: handleTap) {
            HStack(spacing: Constants.Spacing.small) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: Constants.IconSize.small, weight: .semibold))
                }
                
                Text(title)
                    .font(.button)
            }
            .frame(maxWidth: .infinity)
            .frame(height: Constants.Button.height)
            .foregroundColor(foregroundColor)
            .background(
                RoundedRectangle(cornerRadius: Constants.CornerRadius.medium)
                    .stroke(borderColor, lineWidth: Constants.Border.medium)
            )
            .opacity(opacity)
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(Constants.Animation.quick, value: isPressed)
        }
        .disabled(isDisabled)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
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
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
        
        // Perform action
        action()
    }
    
    /// Foreground color based on state
    private var foregroundColor: Color {
        isDisabled ? .gray : .brandPrimary
    }
    
    /// Border color based on state
    private var borderColor: Color {
        isDisabled ? .gray : .brandPrimary
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

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Secondary Button States") {
    VStack(spacing: Constants.Spacing.medium) {
        // Normal state
        SecondaryButton(title: "Cancel", action: {})
        
        // With icon
        SecondaryButton(title: "Edit", action: {}, icon: "pencil")
        
        // Disabled state
        SecondaryButton(title: "Disabled", action: {}, isDisabled: true)
    }
    .padding(Constants.Spacing.large)
}

#Preview("Secondary Button Dark Mode") {
    VStack(spacing: Constants.Spacing.medium) {
        SecondaryButton(title: "Cancel", action: {})
        SecondaryButton(title: "Edit", action: {}, icon: "pencil")
    }
    .padding(Constants.Spacing.large)
    .preferredColorScheme(.dark)
}
#endif
