# Onboarding View Best Practices - SwiftUI (Oct 2025)

## 1. Keep It Short & Focused
- Limit to 3–5 screens.
- Each screen should communicate a single key idea.
- Avoid overwhelming users with too much text.

## 2. Interactive & Swipeable
- Use SwiftUI `TabView` with `.tabViewStyle(PageTabViewStyle())` for swiping.
- Optional: Add a “Next” button for step progression.

## 3. Visuals & Animations
- Use SF Symbols, high-quality images, or subtle animations.
- Avoid heavy graphics that degrade performance.
- Animated progress indicators are encouraged.

## 4. Clear Call-to-Actions
- Each screen should have a primary action: “Next” or “Continue”.
- Final screen: “Get Started” button.
- Optional skip button for experienced users.

## 5. Respect User Preferences & Privacy
- Only request permissions (notifications, HealthKit) when needed.
- Do not force login during onboarding.
- Ensure users can skip optional setups.

## 6. Store Onboarding Completion
- Track completion using UserDefaults or SwiftData:
```swift
@AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
```
- Show onboarding only if `hasCompletedOnboarding == false`.

## 7. Accessibility & Dynamic Type
- Use dynamic text sizes (`.title`, `.headline`) to support resizing.
- Provide VoiceOver labels for all images, buttons, and icons.
- Ensure sufficient contrast and tappable areas.

## 8. Design Patterns & Modular Structure
- Create reusable `OnboardingStepView` for each screen.
- Parent `OnboardingView` wraps all steps in `TabView`.
- Folder structure:
```
/Views/Onboarding
    OnboardingStepView.swift
    OnboardingView.swift
```
- Include SwiftUI Previews for all steps.

## 9. Optional Enhancements
- Progress bar or dots to indicate page number.
- Personalization prompts (fasting goals, supplement schedules).
- Subtle animations to highlight interaction.
- Skip button for faster access to main app.

## 10. Pre-commit Checklist
- [ ] All onboarding screens are swipeable and functional.
- [ ] Each screen communicates one key idea.
- [ ] Buttons and actions are labeled and accessible.
- [ ] UserDefaults/AppStorage tracking implemented.
- [ ] Dynamic type, VoiceOver, and contrast checked.
- [ ] SwiftUI Previews for all step views.
- [ ] Optional enhancements implemented if included.

