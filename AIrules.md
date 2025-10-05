# SwiftUI Fasting + Supplement Planner App - AI Code Editor Guidelines (Oct 2025)

## 1. Project Vision

- Minimalist fasting tracker with supplement reminders.
- Fully offline MVP using **local data** (SwiftData).
- Scalable for future expansion (iCloud, HealthKit, AI features).
- Include pre-commit checklist steps to ensure code quality.

## 2. Architecture & File Structure

- **MVVM** pattern.
- **Folders:**
  - `/Models`
  - `/ViewModels`
  - `/Views`
  - `/Services` (notifications, storage)
  - `/Utils`
- **SwiftUI lifecycle**: `@main struct AppName: App`
- **Pre-commit check:** Verify folder structure and file naming consistency.

## 3. Data Layer (Models)

- **Entities:**
  - `FastingSession`: startTime, endTime, isActive, duration
  - `Supplement`: name, dosage, timing (before/after meal), reminderTime
- **Persistence:** SwiftData `@Model` structs.
- Include mock preview data for SwiftUI previews.
- **Pre-commit check:** Ensure all models have proper @Model attributes and previews for testing.

## 4. ViewModels

- Use `ObservableObject` for each screen.
- `@Published` for reactive updates.
- Business logic inside ViewModel, Views are passive.
- Handle saving/loading with SwiftData context.
- **Pre-commit check:** Confirm ViewModel unit tests exist for all critical logic.

## 5. Views (SwiftUI)

- **Structure:** NavigationStack, TabView, List/Form.
- **UI Guidelines:**
  - Rounded corners: 8–16pt
  - System icons (SF Symbols)
  - Adaptive dark/light mode
  - Minimal animations
- Use `.sheet` or `.popover` for forms.
- **Pre-commit check:** Ensure all Views have previews and accessibility labels.

## 6. Notifications

- Use `UNUserNotificationCenter` for local reminders.
- Create a dedicated service class:

```swift
class NotificationService {
    static let shared = NotificationService()
    func scheduleSupplementReminder(for supplement: Supplement) { }
}
```

- **Pre-commit check:** Verify notifications are scheduled correctly and permission handling exists.

## 7. Performance & Quality

- Use `@MainActor` for UI updates.
- Avoid storing computed data; compute dynamically.
- Lazy loading in lists.
- Small reusable views to limit redraws.
- Test with Instruments for leaks/performance.
- **Pre-commit check:** Run performance profiling and linting before commit.

## 8. Scalability Principles

- Modular code for each feature.
- Abstract system integrations for future API or cloud.
- Efficient Swift idioms; avoid premature optimization.
- Plan data model migrations for future attributes.
- **Pre-commit check:** Confirm code is modular and adheres to project architecture.

## 9. Design & Accessibility

- Follow Apple HIG 2025.
- SF Font, dynamic type, medium headers.
- Accent color via Asset Catalog.
- Spacing: small 8pt, medium 16pt, large 24pt.
- Corner radius: 12–16pt.
- Add accessibility labels and VoiceOver support.
- **Pre-commit check:** Validate color contrast, dynamic type support, and accessibility labels.

## 10. Testing & Maintainability

- SwiftUI Previews for all views.
- Unit test ViewModels using Swift Testing (Xcode 17+).
- Store constants in `Constants.swift`.
- Error handling via alerts.
- **Pre-commit check:** All new code should pass unit tests and compile without warnings.

## 11. Versioning & Future Features

- Plan iCloud sync, HealthKit integration, and AI assistant features.
- Keep modular to avoid rewrites.
- Widgets and charts can be added later.
- **Pre-commit check:** Tag new features with TODO comments and version notes.

## 12. AI Code Editor Guidelines

- Always generate MVVM-compliant SwiftUI code.
- Use SwiftData local models.
- Keep Views declarative; business logic in ViewModel.
- Follow HIG 2025 for design.
- Schedule notifications via dedicated service class.
- Support dark/light mode, dynamic type, and accessibility.
- Modular, testable, scalable, and performant code only.
- **Pre-commit check:** Ensure generated code follows all above rules and guidelines.

## 13. AI Prompt Templates & Windsurf Shortcut Workflow

- **Save your master prompt template** in Windsurf including all rules, pre-commit instructions, MVVM, SwiftData, SwiftUI, and accessibility requirements.
- Assign a **keyboard shortcut** in Windsurf to trigger the template instantly.
- When coding:
  1. Place the cursor where new code is needed.
  2. Press Windsurf shortcut.
  3. The AI generates code following all project rules and pre-commit checklist.
  4. Review, tweak if necessary, then commit.
- Maintain smaller specialized templates for NotificationService, Fasting timer View + ViewModel, Supplement CRUD View + ViewModel.
- This ensures **repeatable, high-quality code generation** and reduces the risk of rule violations before commit.

