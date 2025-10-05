# App Store Submission Rule Set - SwiftUI Apps (Oct 2025)

## 1. Functionality & Stability
- Ensure the app **launches and runs without crashes** on all supported devices.
- Test on multiple simulators and real devices.
- No broken links, buttons, or features.
- All core features must work offline if advertised.
- **LaunchScreen** must be present and configured correctly.

## 2. User Interface & UX
- Follow **Apple HIG 2025**:
  - Consistent typography, spacing, and color usage.
  - Dark and light mode support.
  - Responsive layouts for all device sizes.
- All interactive elements must be tappable and accessible.
- No placeholder text, dummy images, or debug UI elements.
- Touch targets must be at least 44pt.
- Smooth animations without jitter.

## 3. Onboarding & First Launch
- Onboarding must be functional and dismissible.
- Track completion using `UserDefaults` or SwiftData.
- Permissions (notifications, HealthKit) requested **only when needed**.

## 4. Privacy & Permissions ⚠️ CRITICAL (2025 Updates)
- **Privacy Manifest File (PrivacyInfo.xcprivacy)** - REQUIRED for all apps
- Include a **Privacy Policy** URL (publicly accessible, no login required).
- Complete **Privacy Nutrition Labels** in App Store Connect.
- Declare all **Required Reason APIs** (UserDefaults, file timestamps, etc.).
- Explain the purpose of any permission requests with clear usage descriptions.
- Only request necessary permissions (notifications, HealthKit, location if needed).
- No background data collection without explicit user consent.
- Sensitive data must be stored securely.
- **Health data CANNOT be used for advertising or data mining.**
- **Health data CANNOT be stored in iCloud.**

## 5. Data Handling & Storage
- Use secure storage (SwiftData, Keychain if needed).
- Do not include personal data without consent.
- Ensure proper handling of offline/online states.
- Implement data persistence correctly and test migration if needed.
- All network requests must use HTTPS.

## 6. Notifications
- Only send notifications that are meaningful to the user.
- Users must be able to control notification settings.
- No spamming or misleading notification messages.
- Notification frequency must comply with Apple guidelines.

## 7. App Icons & Assets
- App icon must meet Apple’s resolution and size requirements.
- All images must be high quality, non-copyrighted.
- Avoid stretched or pixelated images.
- **LaunchScreen** image or SwiftUI launch view must be correctly configured.

## 8. Accessibility
- Use VoiceOver labels for all buttons, icons, and images.
- Support dynamic type and scalable fonts.
- Ensure sufficient contrast ratios for text and interactive elements.

## 9. Content & Metadata
- App name, description, screenshots, and keywords must be accurate and non-misleading.
- Screenshots must reflect the final UI.
- Ratings and review prompts must follow Apple guidelines.
- Localized metadata must match supported languages.

## 10. Testing & QA ⚠️ (2025 SDK Requirements)
- **Build with Xcode 16 or later** (REQUIRED since April 2025).
- **Use iOS 18 SDK or later** (REQUIRED since April 2025).
- Test on the **latest iOS version** (iOS 18) and at least **two previous major versions**.
- Test on **iPhone and iPad** if supported.
- Validate network handling, offline mode, and error messages.
- Use Xcode pre-submit tools to check for warnings and build issues.
- Remove debug logging and placeholder accounts.

## 11. Legal & Compliance
- Correct age rating in App Store Connect.
- **Complete new age rating questionnaire by January 31, 2026.**
- Include licenses for third-party libraries.
- Include Terms of Service if health or supplement tracking is involved.
- **Medical disclaimer required for health apps.**
- No misleading use of Apple brand or trademark.
- GDPR compliance for EU users.
- CCPA compliance for California users.

## 12. Pre-commit / Pre-upload Checklist ⚠️ (2025 Updates)

### Critical 2025 Requirements:
- [ ] **Built with Xcode 16 or later** (REQUIRED).
- [ ] **Using iOS 18 SDK or later** (REQUIRED).
- [ ] **PrivacyInfo.xcprivacy file exists and is complete** (REQUIRED).
- [ ] **Privacy Nutrition Labels completed in App Store Connect** (REQUIRED).
- [ ] **Required Reason APIs declared** (UserDefaults, etc.).
- [ ] **Medical disclaimer present in app** (for health apps).

### Standard Requirements:
- [ ] App launches without crashes on all supported devices.
- [ ] **LaunchScreen is present and configured correctly.**
- [ ] All onboarding screens are functional and dismissible.
- [ ] Permissions requested only when needed, with proper explanations.
- [ ] All core features work offline if advertised.
- [ ] SwiftUI previews exist for all custom views.
- [ ] App icon and assets meet Apple guidelines.
- [ ] Accessibility features implemented (VoiceOver, dynamic type, contrast).
- [ ] Screenshots and metadata match the app content.
- [ ] Notification usage follows Apple policies.
- [ ] Tested on latest iOS (18) and older supported versions.
- [ ] Privacy policy URL included and accessible.
- [ ] No debug code or placeholders present in the release build.
- [ ] Age rating, TOS, and licenses are included.
- [ ] All background modes declared are necessary.
- [ ] App startup time is reasonable.
- [ ] Supported device orientations declared and handled correctly.
- [ ] Touch targets meet minimum size guidelines.
- [ ] No spamming or misleading notifications.
- [ ] All network calls are secure (HTTPS).

### Health App Specific:
- [ ] No medical diagnosis or treatment features.
- [ ] No dosage calculations.
- [ ] Health data not used for advertising.
- [ ] Health data not stored in iCloud.
- [ ] Medical disclaimers in app and App Store description.

