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

## 4. Privacy & Permissions
- Include a **Privacy Policy** URL.
- Explain the purpose of any permission requests.
- Only request necessary permissions (notifications, HealthKit, location if needed).
- No background data collection without explicit user consent.
- Sensitive data must be stored securely.

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

## 10. Testing & QA
- Test on the **latest iOS version** and at least **two previous major versions**.
- Test on **iPhone and iPad** if supported.
- Validate network handling, offline mode, and error messages.
- Use Xcode pre-submit tools to check for warnings and build issues.
- Remove debug logging and placeholder accounts.

## 11. Legal & Compliance
- Correct age rating in App Store Connect.
- Include licenses for third-party libraries.
- Include Terms of Service if health or supplement tracking is involved.
- No misleading use of Apple brand or trademark.

## 12. Pre-commit / Pre-upload Checklist
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
- [ ] Tested on latest iOS and older supported versions.
- [ ] Privacy policy URL included and accurate.
- [ ] No debug code or placeholders present in the release build.
- [ ] Age rating, TOS, and licenses are included.
- [ ] All background modes declared are necessary.
- [ ] App startup time is reasonable.
- [ ] Supported device orientations declared and handled correctly.
- [ ] Touch targets meet minimum size guidelines.
- [ ] No spamming or misleading notifications.
- [ ] All network calls are secure (HTTPS).

