# MVP Polishing Rules - SwiftUI Cheap Wins (Oct 2025)

## 1. System Defaults
- Use SF Symbols for all icons.
- Use system colors (`.primary`, `.secondary`, `.systemBackground`) for automatic dark/light mode.
- Use system fonts (`.title`, `.headline`, `.body`) for dynamic type support.

## 2. SwiftUI Previews
- Create SwiftUI previews for each view.
- Preview in multiple devices, light/dark modes.

## 3. Rounded Corners & Shadows
- Apply small rounded corners (8–16pt) on buttons, cards, and list items.
- Use soft shadows (`.shadow(radius: 3)`) for depth.

## 4. Consistent Padding & Spacing
- Define constants for small (8pt), medium (16pt), large (24pt) spacing.
- Apply consistently across views for clean layouts.

## 5. Subtle Animations
- Use SwiftUI implicit animations (`withAnimation`) for transitions.
- Examples: button taps, showing/hiding forms, expanding/collapsing lists.
- Keep animations smooth and minimal.

## 6. Placeholder & Empty States
- Display friendly messages for empty lists or views:
```swift
Text("No supplements added yet!").italic().foregroundColor(.secondary)
```
- Avoid blank screens.

## 7. Accent Color & Branding
- Set a consistent accent color in Asset Catalog.
- Apply consistently for buttons, links, and highlights.

## 8. Haptic Feedback
- Use simple haptic feedback for user actions:
```swift
import UIKit
UIImpactFeedbackGenerator(style: .medium).impactOccurred()
```

## 9. Accessibility
- Add `accessibilityLabel` for icons and buttons.
- Support dynamic type and VoiceOver.
- Ensure sufficient contrast for text and interactive elements.

## 10. Dark/Light Mode Support
- Ensure views adapt naturally using system colors and assets.
- Verify UI looks correct in both modes.

## 11. Pre-commit Checklist
- [ ] SF Symbols used for all icons.
- [ ] System colors and fonts applied.
- [ ] SwiftUI previews exist for all views.
- [ ] Rounded corners and shadows applied.
- [ ] Spacing and padding consistent.
- [ ] Animations are smooth and minimal.
- [ ] Empty states handled with friendly messages.
- [ ] Accent color consistent across app.
- [ ] Haptic feedback implemented where appropriate.
- [ ] Accessibility labels added and dynamic type supported.
- [ ] Dark/light mode verified.

