# Fast To Habit - Design System Documentation

**Version:** 1.0  
**Last Updated:** October 5, 2025  
**Status:** ✅ Complete

---

## Overview

This document defines the complete design system for Fast To Habit, including colors, typography, spacing, components, and usage guidelines. All design decisions follow Apple's Human Interface Guidelines and prioritize accessibility.

---

## 🎨 Color System

### Brand Colors

| Color | Light Mode | Dark Mode | Usage |
|-------|-----------|-----------|-------|
| **Primary** | `#007AFF` | `#0A84FF` | Fasting features, primary CTAs |
| **Secondary** | `#AF52DE` | `#BF5AF2` | Supplement features |
| **Accent** | `#007AFF` | `#0A84FF` | Important actions, highlights |

### Semantic Colors

| Color | Light Mode | Dark Mode | Usage |
|-------|-----------|-----------|-------|
| **Fasting Active** | `#007AFF` | `#0A84FF` | Active fasting state |
| **Fasting Complete** | `#34C759` | `#30D158` | Completed fasts |
| **Supplement Reminder** | `#AF52DE` | `#BF5AF2` | Supplement notifications |
| **Supplement Complete** | `#34C759` | `#30D158` | Taken supplements |

### Status Colors

| Color | Light Mode | Dark Mode | Usage |
|-------|-----------|-----------|-------|
| **Success** | `#34C759` | `#30D158` | Success messages, completed actions |
| **Warning** | `#FF9500` | `#FF9F0A` | Warnings, reminders |
| **Error** | `#FF3B30` | `#FF453A` | Errors, destructive actions |
| **Info** | `#007AFF` | `#0A84FF` | Informational messages |

### UI Colors

| Color | Purpose |
|-------|---------|
| **Background Primary** | Main screen background |
| **Background Secondary** | Card backgrounds, elevated surfaces |
| **Background Tertiary** | Nested cards, input fields |
| **Card Background** | Card container background |
| **Text Primary** | Main text content |
| **Text Secondary** | Secondary text, captions |
| **Text Tertiary** | Hints, placeholders |
| **Divider** | Separators, borders |
| **Border** | Input borders, outlines |

### Interactive Colors

| Color | Purpose |
|-------|---------|
| **Button Primary** | Primary button background |
| **Button Secondary** | Secondary button background |
| **Button Text** | Button text color |
| **Disabled** | Disabled state elements |

### Implementation

```swift
// Usage in code
Color.brandPrimary
Color.fastingActive
Color.success
Color.textPrimary
```

---

## 📝 Typography

### Font System

Fast To Habit uses **SF Pro** (system font) for consistency with iOS and automatic Dynamic Type support.

### Text Styles

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| **Title Large** | 34pt | Bold | Main screen titles |
| **Title Medium** | 28pt | Bold | Section headers, modal titles |
| **Title Small** | 22pt | Semibold | Card titles, list headers |
| **Headline** | 17pt | Semibold | Card headers, emphasized content |
| **Subheadline** | 15pt | Semibold | List item titles, form labels |
| **Body Regular** | 17pt | Regular | Main content, descriptions |
| **Body Small** | 15pt | Regular | Secondary content, list items |
| **Callout** | 16pt | Regular | Hints, helper text |
| **Caption** | 12pt | Regular | Timestamps, metadata |
| **Caption Small** | 11pt | Regular | Fine print, legal text |
| **Button** | 17pt | Semibold | Button text |
| **Button Small** | 15pt | Semibold | Compact buttons |
| **Display Large** | 48pt | Bold (Rounded) | Timer display, large numbers |
| **Display Medium** | 34pt | Semibold (Rounded) | Stats, progress indicators |
| **Monospaced Numbers** | 17pt | Regular (Monospaced) | Countdown timers |

### Implementation

```swift
// Usage in code
Text("Title").font(.titleLarge)
Text("Body").font(.bodyRegular)
Text("Caption").font(.caption)

// With view modifiers
Text("Title").titleLargeStyle()
Text("Body").bodyStyle()
```

### Accessibility

- All text styles support **Dynamic Type**
- Test with largest accessibility text size
- Maintain minimum 4.5:1 contrast ratio (WCAG AA)
- Use semantic text styles for VoiceOver

---

## 📏 Spacing System

### Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| **Small** | 8pt | Tight spacing, icon padding |
| **Medium** | 16pt | Standard spacing, list items |
| **Large** | 24pt | Section spacing, card padding |
| **Extra Large** | 32pt | Screen margins, major sections |

### Implementation

```swift
.padding(Constants.Spacing.small)
.padding(Constants.Spacing.medium)
VStack(spacing: Constants.Spacing.large)
```

---

## 🔲 Corner Radius

| Token | Value | Usage |
|-------|-------|-------|
| **Small** | 8pt | Small elements, badges |
| **Medium** | 12pt | Buttons, cards |
| **Large** | 16pt | Large cards, modals |

---

## 🎭 Shadows

### Card Shadow

- **Radius:** 4pt
- **Opacity:** 0.1
- **Offset:** (0, 2)
- **Color:** Black

### Standard Shadow

- **Radius:** 3pt
- **Opacity:** 0.1
- **Offset:** (0, 0)

---

## 🎬 Animations

### Animation Durations

| Token | Duration | Usage |
|-------|----------|-------|
| **Quick** | 0.2s | Subtle changes, button presses |
| **Standard** | 0.3s | Most UI transitions |
| **Slow** | 0.5s | Important transitions, modals |

### Animation Curves

- **Standard:** `easeInOut`
- **Spring:** `spring(response: 0.3, dampingFraction: 0.7)`

### Implementation

```swift
.animation(Constants.Animation.quick, value: isPressed)
.animation(Constants.Animation.standard, value: showModal)
```

---

## 🔘 Opacity Values

| Token | Value | Usage |
|-------|-------|-------|
| **Disabled** | 0.4 | Disabled elements |
| **Secondary** | 0.6 | Secondary content |
| **Pressed** | 0.8 | Button pressed state |
| **Overlay** | 0.5 | Modal overlays |

---

## 🎯 Icon Sizes

| Token | Size | Usage |
|-------|------|-------|
| **Small** | 16pt | Inline with text |
| **Medium** | 24pt | Buttons, list items |
| **Large** | 32pt | Headers, feature icons |
| **Extra Large** | 48pt | Empty states, onboarding |

---

## 🧩 Components

### PrimaryButton

**Purpose:** Main call-to-action buttons

**Features:**
- Filled background with brand primary color
- Loading state with spinner
- Disabled state with reduced opacity
- Haptic feedback on tap
- Optional SF Symbol icon
- Accessibility labels

**Usage:**
```swift
PrimaryButton(title: "Start Fasting", action: {})
PrimaryButton(title: "Start", action: {}, icon: "play.fill")
PrimaryButton(title: "Loading", action: {}, isLoading: true)
PrimaryButton(title: "Disabled", action: {}, isDisabled: true)
```

**Dimensions:**
- Height: 50pt
- Corner Radius: 12pt
- Horizontal Padding: 24pt

---

### SecondaryButton

**Purpose:** Less prominent actions

**Features:**
- Outlined style with transparent background
- Border color matches brand primary
- Haptic feedback on tap
- Optional SF Symbol icon
- Accessibility labels

**Usage:**
```swift
SecondaryButton(title: "Cancel", action: {})
SecondaryButton(title: "Edit", action: {}, icon: "pencil")
```

**Dimensions:**
- Height: 50pt
- Border Width: 2pt
- Corner Radius: 12pt

---

### Card

**Purpose:** Container for grouped content

**Features:**
- Consistent padding and corner radius
- Optional shadow
- Optional title
- Tappable with haptic feedback
- Adapts to light/dark mode

**Usage:**
```swift
Card {
    Text("Content")
}

Card(title: "Title") {
    Text("Content")
}

Card(title: "Tappable", onTap: {}) {
    Text("Content")
}
```

**Dimensions:**
- Padding: 16pt
- Corner Radius: 12pt
- Shadow Radius: 4pt

---

### EmptyStateView

**Purpose:** Display when lists or screens have no content

**Features:**
- SF Symbol icon
- Title and message text
- Optional action button
- Centered layout

**Usage:**
```swift
EmptyStateView(
    icon: "clock.badge.questionmark",
    title: "No Active Fasts",
    message: "Start your first fasting session",
    actionTitle: "Start Fasting",
    action: {}
)
```

---

### LoadingView

**Purpose:** Show loading state

**Features:**
- Progress spinner
- Optional message
- Overlay mode with semi-transparent background
- Centered layout

**Usage:**
```swift
LoadingView()
LoadingView(message: "Loading...")
LoadingView(message: "Saving...", isOverlay: true)
```

---

## 📱 Layout Guidelines

### Screen Padding

- **Horizontal:** 20pt
- **Maximum Content Width:** 600pt (for larger screens)

### List Items

- **Height:** 60pt
- **Spacing:** 16pt

### Sections

- **Spacing:** 32pt

---

## ♿️ Accessibility

### Requirements

1. **Dynamic Type Support**
   - All text styles scale with user preferences
   - Test with largest accessibility text size
   - Ensure layouts don't break at large sizes

2. **Color Contrast**
   - Minimum 4.5:1 for normal text (WCAG AA)
   - Minimum 3:1 for large text
   - Test in both light and dark mode

3. **VoiceOver**
   - All interactive elements have accessibility labels
   - Buttons have accessibility hints when needed
   - Images have accessibility descriptions

4. **Haptic Feedback**
   - Buttons provide haptic feedback on tap
   - Different intensities for different actions
   - Medium impact for primary actions
   - Light impact for secondary actions

5. **Touch Targets**
   - Minimum 44x44pt for all interactive elements
   - Buttons meet minimum height requirements
   - Adequate spacing between tappable elements

---

## 🎨 Design Principles

### 1. Consistency
- Use design tokens (Colors, Typography, Spacing) everywhere
- Reuse components instead of creating one-offs
- Follow established patterns

### 2. Clarity
- Clear visual hierarchy
- Adequate white space
- Readable text sizes
- High contrast

### 3. Simplicity
- Minimal UI elements
- Focus on core functionality
- Remove unnecessary decoration
- Clean, modern aesthetic

### 4. Trustworthiness
- Professional appearance
- Calming colors (blues, greens)
- Consistent behavior
- Clear feedback

### 5. Health-Focused
- Calming color palette
- Clear progress indicators
- Positive reinforcement
- Non-aggressive design

---

## 🧪 Testing Checklist

### Visual Testing

- [ ] Test all components in light mode
- [ ] Test all components in dark mode
- [ ] Test on iPhone SE (small screen)
- [ ] Test on iPhone Pro Max (large screen)
- [ ] Test on iPad (tablet layout)

### Accessibility Testing

- [ ] Test with VoiceOver enabled
- [ ] Test with largest Dynamic Type size
- [ ] Test with reduced motion enabled
- [ ] Verify color contrast ratios
- [ ] Test touch target sizes

### Interaction Testing

- [ ] Verify haptic feedback works
- [ ] Test button states (normal, pressed, disabled, loading)
- [ ] Test animations and transitions
- [ ] Verify empty states display correctly
- [ ] Test loading states

---

## 📁 File Structure

```
FastToHabit/
├── Utils/
│   ├── Constants.swift       # Design tokens
│   ├── Colors.swift          # Color system
│   └── Typography.swift      # Typography system
├── Views/
│   ├── Components/
│   │   ├── PrimaryButton.swift
│   │   ├── SecondaryButton.swift
│   │   ├── Card.swift
│   │   ├── EmptyStateView.swift
│   │   └── LoadingView.swift
│   └── DesignSystemPreview.swift
└── Assets.xcassets/
    └── Colors/               # Color assets
```

---

## 🚀 Usage Guidelines

### When to Use Each Component

**PrimaryButton:**
- Main actions (Start Fasting, Save, Submit)
- One per screen maximum
- Most important action

**SecondaryButton:**
- Cancel actions
- Less important actions
- Multiple allowed per screen

**Card:**
- Group related content
- Display information
- Interactive list items

**EmptyStateView:**
- Empty lists
- No data states
- First-time user experience

**LoadingView:**
- Data fetching
- Saving operations
- Async operations

---

## 🔄 Maintenance

### Adding New Colors

1. Add color to `Colors.swift`
2. Create color set in `Assets.xcassets`
3. Set light and dark mode values
4. Update this documentation
5. Add to `DesignSystemPreview`

### Adding New Components

1. Create component in `Views/Components/`
2. Follow existing component patterns
3. Add documentation comments
4. Include SwiftUI previews
5. Add to `DesignSystemPreview`
6. Update this documentation

### Updating Design Tokens

1. Update value in `Constants.swift`
2. Test all affected components
3. Update documentation
4. Verify accessibility

---

## 📚 References

- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [SF Symbols](https://developer.apple.com/sf-symbols/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)

---

## ✅ Completion Status

- [x] Color system defined
- [x] Typography system implemented
- [x] Design tokens created
- [x] 5 reusable components built
- [x] Design system preview created
- [x] Documentation complete
- [x] Accessibility guidelines defined
- [x] Testing checklist provided

---

**Next Steps:**
1. Add color sets to Xcode Assets.xcassets
2. Test design system on real device
3. Verify accessibility with VoiceOver
4. Begin feature development using components

---

[Rule: Design System, Component Library, Documentation, Accessibility]
