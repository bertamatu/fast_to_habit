import SwiftUI

/// Reusable card container component
/// Features: Consistent styling, shadow, padding, accessibility
/// [Rule: Component Library, Documentation]
struct Card<Content: View>: View {
    
    // MARK: - Properties
    
    /// Content to display inside the card
    let content: Content
    
    /// Optional card title
    var title: String? = nil
    
    /// Whether to show shadow
    var showShadow: Bool = true
    
    /// Custom padding (uses default if nil)
    var padding: CGFloat? = nil
    
    /// Optional tap action
    var onTap: (() -> Void)? = nil
    
    // MARK: - Initialization
    
    init(
        title: String? = nil,
        showShadow: Bool = true,
        padding: CGFloat? = nil,
        onTap: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.showShadow = showShadow
        self.padding = padding
        self.onTap = onTap
        self.content = content()
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.medium) {
            // Title if provided
            if let title = title {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            
            // Content
            content
        }
        .padding(padding ?? Constants.Card.padding)
        .background(
            RoundedRectangle(cornerRadius: Constants.Card.cornerRadius)
                .fill(Color.cardBackground)
                .shadow(
                    color: showShadow ? Color.black.opacity(Constants.Card.shadowOpacity) : .clear,
                    radius: Constants.Card.shadowRadius,
                    x: 0,
                    y: Constants.Card.shadowY
                )
        )
        .contentShape(Rectangle())
        .onTapGesture {
            if let onTap = onTap {
                // Haptic feedback
                let impact = UIImpactFeedbackGenerator(style: .light)
                impact.impactOccurred()
                onTap()
            }
        }
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Card Variants") {
    ScrollView {
        VStack(spacing: Constants.Spacing.large) {
            // Simple card
            Card {
                Text("This is a simple card with default styling")
                    .font(.bodyRegular)
            }
            
            // Card with title
            Card(title: "Fasting Progress") {
                VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                    Text("16:8 Intermittent Fasting")
                        .font(.bodyRegular)
                    Text("12 hours remaining")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // Card without shadow
            Card(showShadow: false) {
                Text("Card without shadow")
                    .font(.bodyRegular)
            }
            
            // Tappable card
            Card(title: "Tap Me", onTap: {
                print("Card tapped!")
            }) {
                HStack {
                    Image(systemName: "hand.tap.fill")
                        .font(.system(size: Constants.IconSize.large))
                        .foregroundColor(.brandPrimary)
                    
                    VStack(alignment: .leading) {
                        Text("Interactive Card")
                            .font(.headline)
                        Text("Tap to perform action")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            
            // Card with custom content
            Card(title: "Supplement Schedule") {
                VStack(spacing: Constants.Spacing.small) {
                    ForEach(0..<3) { index in
                        HStack {
                            Image(systemName: "pills.fill")
                                .foregroundColor(.brandSecondary)
                            Text("Supplement \(index + 1)")
                            Spacer()
                            Text("8:00 AM")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        if index < 2 {
                            Divider()
                        }
                    }
                }
            }
        }
        .padding(Constants.Spacing.large)
    }
}

#Preview("Card Dark Mode") {
    ScrollView {
        VStack(spacing: Constants.Spacing.large) {
            Card(title: "Fasting Progress") {
                Text("16:8 Intermittent Fasting")
                    .font(.bodyRegular)
            }
            
            Card {
                Text("Simple card in dark mode")
                    .font(.bodyRegular)
            }
        }
        .padding(Constants.Spacing.large)
    }
    .preferredColorScheme(.dark)
}
#endif
