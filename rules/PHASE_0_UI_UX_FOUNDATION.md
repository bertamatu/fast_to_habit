# Phase 0: UI/UX Foundation Setup

**Branch:** `UI_UX`  
**Estimated Time:** 3-4 hours  
**Priority:** HIGH (Do before feature development)

## Overview

Establish the visual foundation for Fast To Habit before building features. This ensures consistent design throughout the app and makes feature development faster.

---

## 🎨 Goals

1. ✅ Define color scheme (primary, secondary, accent colors)
2. ✅ Verify and optimize app icons
3. ✅ Create reusable UI components
4. ✅ Set up typography system
5. ✅ Create design tokens (spacing, shadows, etc.)
6. ✅ Build sample screens to test the design system

---

## 📋 Step-by-Step Plan

### **Step 1: Color Scheme & Theme (30 min)**

**Goal:** Define app-wide color palette that works in light and dark mode.

**Tasks:**
- [ ] Define primary color (fasting/health theme - suggest blue/green)
- [ ] Define secondary color (supplements - suggest purple/orange)
- [ ] Define accent color for CTAs
- [ ] Define semantic colors (success, warning, error)
- [ ] Create `Colors.swift` extension with all colors
- [ ] Test colors in both light and dark mode
- [ ] Update `AccentColor` in Assets.xcassets

**Deliverable:** `Utils/Colors.swift` with complete color system

**Design Considerations:**
- Health apps often use calming colors (blues, greens)
- Ensure WCAG AA contrast ratios (4.5:1 for text)
- Colors should feel trustworthy and professional
- Avoid overly bright or aggressive colors

---

### **Step 2: App Icon Review & Optimization (20 min)**

**Goal:** Ensure app icon is perfect and all sizes are present.

**Tasks:**
- [ ] Review existing app icon design
- [ ] Verify all required sizes present (16px to 1024px)
- [ ] Check icon visibility on different backgrounds
- [ ] Ensure no transparency or rounded corners in source
- [ ] Test icon in Xcode simulator
- [ ] Verify icon meets Apple guidelines

**Current Status:** Icons already added (100+ sizes) ✅

**Action:** Review and optimize if needed

---

### **Step 3: Typography System (20 min)**

**Goal:** Define consistent text styles throughout the app.

**Tasks:**
- [ ] Create `Typography.swift` with predefined text styles
- [ ] Define heading styles (H1, H2, H3)
- [ ] Define body text styles (regular, small, caption)
- [ ] Define button text styles
- [ ] Ensure all styles support Dynamic Type
- [ ] Test with largest accessibility text size

**Deliverable:** `Utils/Typography.swift`

**Text Styles to Define:**
- Title Large (screen titles)
- Title Medium (section headers)
- Headline (card titles)
- Body (main content)
- Callout (secondary info)
- Caption (timestamps, hints)
- Button Text

---

### **Step 4: Design Tokens Enhancement (15 min)**

**Goal:** Expand `Constants.swift` with complete design system.

**Tasks:**
- [ ] Add animation durations and curves
- [ ] Add opacity values (disabled, hover, etc.)
- [ ] Add icon sizes (small, medium, large)
- [ ] Add button heights
- [ ] Add card dimensions
- [ ] Document all tokens with comments

**Deliverable:** Enhanced `Utils/Constants.swift`

---

### **Step 5: Reusable UI Components (60 min)**

**Goal:** Create common UI components used throughout the app.

**Tasks:**
- [ ] Create `PrimaryButton.swift` - Main CTA button
- [ ] Create `SecondaryButton.swift` - Secondary actions
- [ ] Create `Card.swift` - Container for content
- [ ] Create `EmptyStateView.swift` - For empty lists
- [ ] Create `LoadingView.swift` - Loading indicator
- [ ] Add SwiftUI previews to all components
- [ ] Test components in light and dark mode

**Deliverable:** `Views/Components/` folder with reusable components

**Components to Build:**

1. **PrimaryButton**
   - Filled background with accent color
   - Rounded corners
   - Haptic feedback on tap
   - Disabled state
   - Loading state

2. **SecondaryButton**
   - Outlined style
   - Transparent background
   - Same size as primary

3. **Card**
   - White/dark background
   - Rounded corners
   - Subtle shadow
   - Padding built-in

4. **EmptyStateView**
   - SF Symbol icon
   - Title and message
   - Optional action button

5. **LoadingView**
   - Progress indicator
   - Optional message

---

### **Step 6: Sample Screens (45 min)**

**Goal:** Build sample screens to test the design system.

**Tasks:**
- [ ] Create `DesignSystemPreview.swift` showing all components
- [ ] Create sample fasting timer screen mockup
- [ ] Create sample supplement list screen mockup
- [ ] Test all components together
- [ ] Verify spacing and alignment
- [ ] Test on different device sizes (iPhone SE, Pro Max, iPad)

**Deliverable:** `Views/DesignSystemPreview.swift`

---

### **Step 7: Launch Screen (15 min)**

**Goal:** Create a professional launch screen.

**Tasks:**
- [ ] Design simple launch screen (app logo centered)
- [ ] Use existing `LaunchLogoCircle.png`
- [ ] Ensure fast loading
- [ ] Test on device

**Deliverable:** Updated Launch Screen configuration

---

### **Step 8: Documentation & Testing (15 min)**

**Goal:** Document the design system and test everything.

**Tasks:**
- [ ] Create `DESIGN_SYSTEM.md` documenting all decisions
- [ ] Take screenshots of components in light/dark mode
- [ ] Test on real device
- [ ] Verify accessibility (VoiceOver, Dynamic Type)
- [ ] Run through color contrast checker

**Deliverable:** `rules/DESIGN_SYSTEM.md`

---

## 🎯 Detailed Task Breakdown

### **Task 1.1: Create Colors.swift**

**File:** `FastToHabit/Utils/Colors.swift`

**Content Structure:**
```swift
import SwiftUI

extension Color {
    // MARK: - Brand Colors
    static let brandPrimary = Color("BrandPrimary")
    static let brandSecondary = Color("BrandSecondary")
    
    // MARK: - Semantic Colors
    static let fastingActive = Color("FastingActive")
    static let supplementReminder = Color("SupplementReminder")
    
    // MARK: - UI Colors
    static let cardBackground = Color("CardBackground")
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
}
```

**Color Suggestions:**
- **Primary (Fasting):** Blue (#007AFF) - trust, calm, health
- **Secondary (Supplements):** Purple (#AF52DE) - wellness, balance
- **Success:** Green (#34C759) - completed fasts
- **Warning:** Orange (#FF9500) - reminders
- **Error:** Red (#FF3B30) - alerts

---

### **Task 1.2: Add Colors to Assets.xcassets**

**Steps:**
1. Open Xcode
2. Select `Assets.xcassets`
3. Right-click → New Color Set
4. Name it (e.g., "BrandPrimary")
5. Set light and dark mode values
6. Repeat for all colors

---

### **Task 3.1: Create Typography.swift**

**File:** `FastToHabit/Utils/Typography.swift`

**Content Structure:**
```swift
import SwiftUI

extension Font {
    // MARK: - Titles
    static let titleLarge = Font.system(size: 34, weight: .bold, design: .default)
    static let titleMedium = Font.system(size: 28, weight: .bold, design: .default)
    
    // MARK: - Body
    static let bodyRegular = Font.system(size: 17, weight: .regular, design: .default)
    static let bodySmall = Font.system(size: 15, weight: .regular, design: .default)
    
    // MARK: - Captions
    static let caption = Font.system(size: 12, weight: .regular, design: .default)
}
```

---

### **Task 5.1: Create PrimaryButton Component**

**File:** `FastToHabit/Views/Components/PrimaryButton.swift`

**Features:**
- Customizable title
- Loading state
- Disabled state
- Haptic feedback
- Consistent styling
- Accessibility labels

---

## 📊 Success Criteria

**Phase 0 is complete when:**

- [ ] ✅ All colors defined and working in light/dark mode
- [ ] ✅ Typography system implemented
- [ ] ✅ 5 reusable components created with previews
- [ ] ✅ Design system preview screen built
- [ ] ✅ All components tested on real device
- [ ] ✅ Accessibility verified (VoiceOver, Dynamic Type)
- [ ] ✅ Documentation complete
- [ ] ✅ All changes committed to `UI_UX` branch

---

## 🚀 Quick Start Checklist

**Start here:**

1. [ ] Create `Utils/Colors.swift`
2. [ ] Add color sets to `Assets.xcassets`
3. [ ] Create `Utils/Typography.swift`
4. [ ] Update `Utils/Constants.swift`
5. [ ] Create `Views/Components/` folder
6. [ ] Build PrimaryButton component
7. [ ] Build other components
8. [ ] Create DesignSystemPreview
9. [ ] Test everything
10. [ ] Document and commit

---

## 📁 File Structure After Phase 0

```
FastToHabit/
├── Utils/
│   ├── Constants.swift (enhanced)
│   ├── Colors.swift (new)
│   └── Typography.swift (new)
├── Views/
│   ├── Components/
│   │   ├── PrimaryButton.swift
│   │   ├── SecondaryButton.swift
│   │   ├── Card.swift
│   │   ├── EmptyStateView.swift
│   │   └── LoadingView.swift
│   └── DesignSystemPreview.swift
├── Assets.xcassets/
│   ├── Colors/
│   │   ├── BrandPrimary.colorset
│   │   ├── BrandSecondary.colorset
│   │   └── ... (more colors)
│   └── AppIcon.appiconset/ (verified)
└── rules/
    └── DESIGN_SYSTEM.md (new)
```

---

## 🎨 Design Inspiration

**Health & Wellness App Colors:**
- **Calm Blue:** #007AFF (iOS system blue)
- **Wellness Green:** #34C759 (success green)
- **Balance Purple:** #AF52DE (creativity)
- **Energy Orange:** #FF9500 (warmth)

**Typography:**
- Use SF Pro (system font) for consistency
- Support Dynamic Type for accessibility
- Clear hierarchy (titles → body → captions)

**Spacing:**
- Small: 8pt (tight spacing)
- Medium: 16pt (standard spacing)
- Large: 24pt (section spacing)
- Extra Large: 32pt (screen margins)

---

## 🔄 After Phase 0

**Next Steps:**
1. Merge `UI_UX` branch to `main`
2. Start Phase 1: Core Fasting Timer (using new components)
3. Features will be faster to build with design system ready

---

## 💡 Pro Tips

1. **Test Early:** Check components in simulator frequently
2. **Dark Mode:** Always test both light and dark mode
3. **Accessibility:** Use Accessibility Inspector in Xcode
4. **Consistency:** Use design tokens (Constants, Colors, Typography) everywhere
5. **Previews:** Add SwiftUI previews to every component
6. **Documentation:** Comment your design decisions

---

## 📚 Reference Documents

- `rules/mvp_polish_UI_rules.md` - UI polish guidelines
- `rules/AIrules.md` - Architecture and code style
- Apple HIG: https://developer.apple.com/design/human-interface-guidelines/

---

**Estimated Total Time:** 3-4 hours  
**Difficulty:** Medium  
**Impact:** HIGH (Speeds up all future development)

---

**Ready to start?** Begin with Step 1: Color Scheme & Theme!

[Rule: UI/UX Foundation, Design System, Component Library]
