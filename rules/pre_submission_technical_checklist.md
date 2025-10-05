# Pre-Submission Technical Checklist (Oct 2025)

## Overview
This checklist ensures your app meets all technical requirements for App Store submission in October 2025. Complete ALL items before uploading to App Store Connect.

## 1. Build Requirements ⚠️ CRITICAL

### Xcode & SDK Version
- [ ] Built with **Xcode 16 or later**
- [ ] Using **iOS 18 SDK** (or later)
- [ ] Deployment target set appropriately (iOS 16+ recommended)
- [ ] No deprecated API warnings
- [ ] All compiler warnings resolved

**How to verify:**
```bash
# Check Xcode version
xcodebuild -version

# Should show: Xcode 16.x or later
```

**In Xcode:**
1. Select project in navigator
2. Select target
3. Build Settings → Base SDK → iOS 18.0 or later
4. Deployment Target → iOS 16.0 or later

### Build Configuration
- [ ] Release build configuration selected
- [ ] Bitcode disabled (deprecated)
- [ ] App Thinning enabled
- [ ] Optimization level set to `-O` (Optimize for Speed)
- [ ] Debug symbols included for crash reports

## 2. Privacy Requirements ⚠️ CRITICAL

### Privacy Manifest File
- [ ] `PrivacyInfo.xcprivacy` file exists in project
- [ ] File added to app target (not test targets)
- [ ] NSPrivacyTracking declared (false for MVP)
- [ ] NSPrivacyCollectedDataTypes declared
- [ ] NSPrivacyAccessedAPITypes declared (UserDefaults, etc.)
- [ ] All Required Reason APIs documented
- [ ] No privacy-related build warnings

**Verification:**
```bash
# Check if file exists
ls -la FastToHabit/PrivacyInfo.xcprivacy

# Validate XML format
plutil -lint FastToHabit/PrivacyInfo.xcprivacy
```

### Privacy Policy
- [ ] Privacy policy written and complete
- [ ] Privacy policy hosted at public URL
- [ ] URL accessible without login
- [ ] URL works on mobile browsers
- [ ] Privacy policy URL added to App Store Connect
- [ ] In-app links to privacy policy working
- [ ] Privacy policy includes all required sections

### Privacy Nutrition Labels
- [ ] Completed in App Store Connect
- [ ] All data types declared accurately
- [ ] Data linking status correct (false for MVP)
- [ ] Tracking status correct (false for MVP)
- [ ] Data purposes declared
- [ ] Third-party data sharing declared (none for MVP)

## 3. App Configuration

### Info.plist Requirements
- [ ] Bundle Identifier matches App Store Connect
- [ ] Version number set (e.g., 1.0.0)
- [ ] Build number set (e.g., 1)
- [ ] Display name set
- [ ] Supported interface orientations declared
- [ ] Required device capabilities declared
- [ ] Status bar style configured

### Permission Descriptions (Usage Strings)
- [ ] `NSUserNotificationsUsageDescription` - "We need permission to send you supplement reminders and fasting notifications."
- [ ] All permission strings clear and specific
- [ ] No placeholder text in permission descriptions

**Example Info.plist entries:**
```xml
<key>NSUserNotificationsUsageDescription</key>
<string>Fast To Habit needs notification permission to remind you about supplement schedules and fasting periods.</string>

<key>UIUserInterfaceStyle</key>
<string>Automatic</string>
```

### App Icons
- [ ] All required icon sizes included
- [ ] App icon meets Apple guidelines (no transparency, no rounded corners in asset)
- [ ] Icon looks good on all backgrounds
- [ ] Icon visible in App Store Connect
- [ ] No alpha channel in app icon

**Required sizes:**
- 1024x1024 (App Store)
- 180x180 (iPhone @3x)
- 120x120 (iPhone @2x)
- 167x167 (iPad Pro @2x)
- 152x152 (iPad @2x)
- 76x76 (iPad @1x)

### Launch Screen
- [ ] Launch screen configured
- [ ] Launch screen displays correctly
- [ ] No placeholder or "Hello World" text
- [ ] Matches app design
- [ ] Fast loading time

## 4. Code Quality

### No Debug Code
- [ ] No `print()` statements in production code
- [ ] No debug breakpoints
- [ ] No test/dummy data in release build
- [ ] No hardcoded test credentials
- [ ] No commented-out code blocks
- [ ] No TODO comments for critical features

### Error Handling
- [ ] All network errors handled (future)
- [ ] User-facing error messages are friendly
- [ ] No raw error messages shown to users
- [ ] App doesn't crash on invalid input
- [ ] Graceful handling of permission denials

### Memory Management
- [ ] No memory leaks detected
- [ ] Proper use of weak/unowned references
- [ ] Large data sets handled efficiently
- [ ] Images optimized and compressed
- [ ] No retain cycles in closures

**Testing:**
```bash
# Run with Instruments
# Product → Profile → Leaks
# Product → Profile → Allocations
```

## 5. Testing Requirements

### Device Testing
- [ ] Tested on real iPhone (not just simulator)
- [ ] Tested on multiple iPhone models
- [ ] Tested on iPad (if supported)
- [ ] Tested on latest iOS version (iOS 18)
- [ ] Tested on iOS 17 (backward compatibility)
- [ ] Tested on iOS 16 (if deployment target allows)

### Functionality Testing
- [ ] App launches without crashes
- [ ] All core features work correctly
- [ ] Fasting timer accuracy verified
- [ ] Notifications delivered on time
- [ ] Data persistence works (SwiftData)
- [ ] App survives force quit and relaunch
- [ ] Onboarding flow completes successfully
- [ ] Settings changes persist

### UI Testing
- [ ] All screens display correctly
- [ ] No UI elements cut off or overlapping
- [ ] Text readable in both light and dark mode
- [ ] Dynamic Type support working
- [ ] Rotation handled correctly (if supported)
- [ ] Keyboard doesn't cover input fields
- [ ] Safe area insets respected
- [ ] No placeholder images or text

### Accessibility Testing
- [ ] VoiceOver labels on all interactive elements
- [ ] VoiceOver navigation works correctly
- [ ] Dynamic Type scaling works (test at largest size)
- [ ] Color contrast meets WCAG guidelines
- [ ] Touch targets at least 44x44 points
- [ ] No color-only information conveyance

### Performance Testing
- [ ] App launches in under 3 seconds
- [ ] Smooth scrolling in lists
- [ ] No frame drops in animations
- [ ] Low memory usage
- [ ] Battery usage acceptable
- [ ] No thermal issues

**Testing tools:**
```bash
# Run performance tests
# Product → Test (⌘U)
# Product → Profile → Time Profiler
```

## 6. Health App Specific

### Medical Compliance
- [ ] Medical disclaimer present in app
- [ ] Medical disclaimer in App Store description
- [ ] No medical diagnosis features
- [ ] No treatment recommendations
- [ ] No dosage calculations
- [ ] No false health claims
- [ ] Educational content factually accurate

### Health Data Handling
- [ ] Health data stored locally only
- [ ] No health data in iCloud
- [ ] No health data used for advertising
- [ ] Fasting timer accurate to the second
- [ ] Supplement reminders reliable

## 7. Notifications

### Notification Setup
- [ ] Notification permission requested appropriately
- [ ] Permission request includes clear explanation
- [ ] App works if permission denied
- [ ] Notifications scheduled correctly
- [ ] Notification content appropriate
- [ ] No spam or excessive notifications
- [ ] Users can control notification settings

### Notification Testing
- [ ] Notifications appear at correct times
- [ ] Notification content displays correctly
- [ ] Tapping notification opens correct screen
- [ ] Notifications work in background
- [ ] Notifications work when app is terminated

## 8. Data & Storage

### SwiftData Implementation
- [ ] Models properly annotated with `@Model`
- [ ] Data persistence working correctly
- [ ] No data loss on app restart
- [ ] Migration strategy in place (if needed)
- [ ] Data validation implemented
- [ ] No corrupt data scenarios

### Data Integrity
- [ ] User data cannot be corrupted
- [ ] Invalid input rejected gracefully
- [ ] Data backup via device backup working
- [ ] No data leaks between users (if multi-user)

## 9. App Store Connect Configuration

### App Information
- [ ] App name set (max 30 characters)
- [ ] Subtitle set (max 30 characters)
- [ ] Primary category selected (Health & Fitness)
- [ ] Secondary category selected (optional)
- [ ] Age rating completed accurately
- [ ] Privacy policy URL added
- [ ] Support URL added
- [ ] Marketing URL added (optional)

### App Description
- [ ] Description written (max 4000 characters)
- [ ] Keywords set (max 100 characters)
- [ ] Promotional text set (max 170 characters)
- [ ] What's New text for version (max 4000 characters)
- [ ] No medical claims in description
- [ ] No misleading information

### Screenshots
- [ ] Screenshots for all required device sizes
- [ ] 6.7" iPhone (iPhone 15 Pro Max)
- [ ] 6.5" iPhone (iPhone 14 Plus)
- [ ] 5.5" iPhone (iPhone 8 Plus) - if supporting older devices
- [ ] 12.9" iPad Pro (if supporting iPad)
- [ ] Screenshots show actual app UI
- [ ] No placeholder or mockup screenshots
- [ ] Text readable in screenshots
- [ ] Screenshots highlight key features

### App Preview Video (Optional)
- [ ] Video shows actual app functionality
- [ ] Video is 15-30 seconds long
- [ ] Video meets Apple specifications
- [ ] Audio appropriate (if included)

## 10. Legal & Compliance

### Age Rating
- [ ] Age rating questionnaire completed
- [ ] Rating appropriate for content
- [ ] No restricted content for rating
- [ ] Parental guidance noted if needed

### Legal Documents
- [ ] Privacy policy complete and accessible
- [ ] Terms of Service created (recommended)
- [ ] EULA created (optional)
- [ ] Medical disclaimer included
- [ ] Contact information provided

### Compliance
- [ ] No copyrighted content without permission
- [ ] No trademark violations
- [ ] Third-party licenses included (if any)
- [ ] Open source licenses acknowledged (if any)
- [ ] GDPR compliance (EU users)
- [ ] CCPA compliance (California users)

## 11. Certificates & Provisioning

### Code Signing
- [ ] Distribution certificate valid
- [ ] Provisioning profile valid
- [ ] Bundle ID matches App Store Connect
- [ ] Team ID correct
- [ ] Automatic signing configured (recommended)
- [ ] No expired certificates

### Capabilities
- [ ] Required capabilities enabled
- [ ] Push Notifications capability (if using)
- [ ] Background Modes configured (if needed)
- [ ] No unnecessary capabilities enabled

**Verification:**
```bash
# Check code signing
codesign -dv --verbose=4 /path/to/YourApp.app

# Verify provisioning profile
security cms -D -i /path/to/profile.mobileprovision
```

## 12. Build Upload

### Archive Creation
- [ ] Archive created successfully
- [ ] Archive validated in Xcode
- [ ] No validation errors
- [ ] No validation warnings (or documented)
- [ ] Build size reasonable (under 200MB recommended)

### Upload to App Store Connect
- [ ] Archive uploaded successfully
- [ ] Build appears in App Store Connect
- [ ] Build processing completed
- [ ] No post-upload errors
- [ ] Build assigned to app version

### Post-Upload Validation
- [ ] No ITMS errors in email
- [ ] No missing compliance warnings
- [ ] No privacy manifest errors
- [ ] No required reason API errors
- [ ] TestFlight build available

## 13. TestFlight Testing (Recommended)

### Internal Testing
- [ ] Build distributed to internal testers
- [ ] Internal testers can install
- [ ] Internal testers report no critical bugs
- [ ] Crash reports reviewed

### External Testing (Optional)
- [ ] Beta App Review passed
- [ ] External testers invited
- [ ] Feedback collected
- [ ] Critical issues resolved

## 14. Final Pre-Submission Checks

### One Last Time
- [ ] App launches without crashes (tested 10+ times)
- [ ] All features work as expected
- [ ] No debug code or test data
- [ ] Privacy policy accessible
- [ ] Medical disclaimers present
- [ ] App Store metadata accurate
- [ ] Screenshots match current app version
- [ ] Version number correct
- [ ] Build number incremented

### Documentation
- [ ] README updated (if open source)
- [ ] Release notes prepared
- [ ] Known issues documented
- [ ] Support documentation ready

### Team Review
- [ ] Code reviewed by team member
- [ ] Design reviewed and approved
- [ ] Legal review completed
- [ ] Privacy review completed
- [ ] Health compliance review completed

## 15. Submission

### Submit for Review
- [ ] Build selected in App Store Connect
- [ ] All metadata finalized
- [ ] Export compliance information provided
- [ ] Advertising identifier usage declared
- [ ] Content rights confirmed
- [ ] Government restrictions acknowledged
- [ ] Submit button clicked

### Review Notes (Optional but Recommended)
```
Thank you for reviewing Fast To Habit!

Test Account (if needed): N/A - No login required

Key Features to Test:
1. Start/stop fasting timer
2. Add supplement with reminder
3. Receive notification when scheduled
4. View fasting history

Medical Disclaimer:
This app is a wellness tracking tool, not a medical device. 
Medical disclaimers are present in the app and App Store description.

Privacy:
- All data stored locally on device (SwiftData)
- No server communication
- No third-party SDKs
- Privacy Manifest included

Contact: [your-email@example.com]
```

## 16. Post-Submission Monitoring

### During Review
- [ ] Monitor App Store Connect for status updates
- [ ] Check email for review team messages
- [ ] Respond to review team within 24 hours if contacted
- [ ] Have device ready for demo if requested

### If Rejected
- [ ] Read rejection reason carefully
- [ ] Review App Store Guidelines section cited
- [ ] Fix issues thoroughly
- [ ] Update build if code changes needed
- [ ] Respond to review team or resubmit
- [ ] Request phone call if clarification needed

## 17. Common Rejection Reasons to Avoid

### Top Rejection Reasons:
1. ❌ Missing privacy policy or inaccessible URL
2. ❌ Incomplete Privacy Nutrition Labels
3. ❌ Missing or incorrect permission descriptions
4. ❌ App crashes on launch
5. ❌ Placeholder content or incomplete features
6. ❌ Medical claims without FDA approval
7. ❌ Missing Privacy Manifest file
8. ❌ Incorrect Required Reason API declarations
9. ❌ Poor user interface or confusing UX
10. ❌ Misleading App Store metadata

### How We Avoid Them:
- ✅ Complete this entire checklist
- ✅ Test thoroughly on real devices
- ✅ Follow all health app guidelines
- ✅ Include all required 2025 privacy features
- ✅ Be honest and accurate in metadata

## 18. Resources

- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [App Store Connect Help](https://developer.apple.com/help/app-store-connect/)
- [TestFlight Documentation](https://developer.apple.com/testflight/)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

## 19. Checklist Summary

**Total Items:** ~150+

**Critical Sections:**
- ✅ Build Requirements (Xcode 16, iOS 18 SDK)
- ✅ Privacy Manifest File
- ✅ Privacy Policy & Nutrition Labels
- ✅ Health App Compliance
- ✅ Testing on Real Devices
- ✅ No Debug Code
- ✅ App Store Connect Configuration

**Estimated Time to Complete:** 4-8 hours (first submission)

## 20. Quick Reference Commands

```bash
# Check Xcode version
xcodebuild -version

# Validate Privacy Manifest
plutil -lint FastToHabit/PrivacyInfo.xcprivacy

# Check code signing
codesign -dv --verbose=4 /path/to/YourApp.app

# Run tests
xcodebuild test -scheme FastToHabit -destination 'platform=iOS Simulator,name=iPhone 15 Pro'

# Create archive
xcodebuild archive -scheme FastToHabit -archivePath ./build/FastToHabit.xcarchive

# Validate archive
xcodebuild -exportArchive -archivePath ./build/FastToHabit.xcarchive -exportPath ./build -exportOptionsPlist ExportOptions.plist -allowProvisioningUpdates
```

---

**Last Updated:** October 2025  
**Next Review:** Before each App Store submission

