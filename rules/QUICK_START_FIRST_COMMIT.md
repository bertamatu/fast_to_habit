# Quick Start Guide - First Commit Checklist

**For Fast To Habit iOS App - October 2025**

This is your essential checklist for the first commit. Complete these items before writing any feature code.

---

## ⚠️ CRITICAL: Do These FIRST

### 1. Create Privacy Manifest File (15 minutes)

**What:** Create `PrivacyInfo.xcprivacy` file in your Xcode project.

**Why:** Required by Apple since 2025. App will be rejected without it.

**How:**
1. Open Xcode
2. Right-click on `FastToHabit` folder in Project Navigator
3. New File → Resource → App Privacy File
4. Name it `PrivacyInfo.xcprivacy`
5. Copy the template from `privacy_manifest_requirements.md` (Section 3)
6. Add file to app target (not test targets)

**Template location:** `rules/privacy_manifest_requirements.md` - Section 3

**Verify:**
```bash
# Check file exists
ls -la FastToHabit/PrivacyInfo.xcprivacy

# Validate XML
plutil -lint FastToHabit/PrivacyInfo.xcprivacy
```

---

### 2. Add Medical Disclaimer to Code (10 minutes)

**What:** Add medical disclaimer to your app's UI.

**Why:** Required for health apps. Protects you legally and meets App Store requirements.

**Where to add:**
1. **Onboarding screen** (first launch)
2. **Settings → About section**
3. **App Store description** (later)

**Disclaimer text:** See `health_app_compliance_rules.md` - Section 4

**Example SwiftUI code:**
```swift
// In your OnboardingView or AboutView
VStack(alignment: .leading, spacing: 12) {
    Text("Medical Disclaimer")
        .font(.headline)
    
    Text("""
    Fast To Habit is a wellness tracking tool for personal use only. 
    It is not intended to diagnose, treat, cure, or prevent any disease.
    
    Always consult with a qualified healthcare provider before starting 
    any fasting regimen or taking dietary supplements.
    
    This app is not a substitute for professional medical advice.
    """)
    .font(.caption)
    .foregroundColor(.secondary)
}
```

---

### 3. Verify Xcode & SDK Version (2 minutes)

**What:** Ensure you're using Xcode 16+ with iOS 18 SDK.

**Why:** Required by Apple since April 2025.

**How to check:**
```bash
xcodebuild -version
# Should show: Xcode 16.x or later
```

**In Xcode:**
1. Open project settings
2. Select target
3. Build Settings → Base SDK → Should be iOS 18.0 or later
4. Deployment Target → Set to iOS 16.0 (for backward compatibility)

**If not Xcode 16:**
- Download from Mac App Store or Apple Developer site
- Update before continuing

---

## 📋 Standard Setup (Do Before Coding Features)

### 4. Set Up Project Structure (5 minutes)

**Verify folders exist:**
```
FastToHabit/
├── Models/
├── ViewModels/
├── Views/
├── Services/
└── Utils/
```

**If missing, create them:**
1. Right-click on `FastToHabit` in Project Navigator
2. New Group → Name it (e.g., "Models")
3. Repeat for all folders

---

### 5. Configure Info.plist (5 minutes)

**Add notification permission description:**

```xml
<key>NSUserNotificationsUsageDescription</key>
<string>Fast To Habit needs notification permission to remind you about supplement schedules and fasting periods.</string>
```

**How to add:**
1. Open `Info.plist`
2. Right-click → Add Row
3. Key: `Privacy - User Notifications Usage Description`
4. Value: (paste description above)

---

### 6. Review Critical Rules (20 minutes)

**Read these documents:**

1. **[health_app_compliance_rules.md](./health_app_compliance_rules.md)** (10 min)
   - What you CANNOT do (medical advice, dosage calculations)
   - What you CAN do (tracking, reminders)
   - Critical for avoiding rejection

2. **[AIrules.md](./AIrules.md)** (10 min)
   - MVVM architecture
   - SwiftData usage
   - Code organization

---

## ✅ First Commit Checklist

Before committing your initial setup:

- [ ] ✅ `PrivacyInfo.xcprivacy` file created and added to project
- [ ] ✅ Privacy Manifest contains correct data declarations
- [ ] ✅ Medical disclaimer added to code (at least in comments for now)
- [ ] ✅ Xcode 16+ verified
- [ ] ✅ iOS 18 SDK verified
- [ ] ✅ Project folders created (Models, ViewModels, Views, Services, Utils)
- [ ] ✅ Info.plist notification permission description added
- [ ] ✅ Read health_app_compliance_rules.md
- [ ] ✅ Read AIrules.md
- [ ] ✅ No placeholder or test code in commit

---

## 🚀 After First Commit - Next Steps

### Phase 1: Core Fasting Timer

**Reference:** `mvp_features.md` - Phase 1

**Tasks:**
1. Create `FastingSession` model with SwiftData
2. Create `FastingViewModel` with start/stop logic
3. Create `FastingView` with countdown display
4. Add SwiftUI previews
5. Write unit tests

**Estimated time:** 4-6 hours

---

## 📚 Quick Reference Links

### Critical Documents (Read First):
- [health_app_compliance_rules.md](./health_app_compliance_rules.md) - What you can/cannot do
- [privacy_manifest_requirements.md](./privacy_manifest_requirements.md) - Privacy Manifest setup
- [AIrules.md](./AIrules.md) - Architecture and coding standards

### Reference During Development:
- [mvp_features.md](./mvp_features.md) - Feature roadmap
- [mvp_polish_UI_rules.md](./mvp_polish_UI_rules.md) - UI guidelines

### Before Submission:
- [pre_submission_technical_checklist.md](./pre_submission_technical_checklist.md) - 150+ item checklist
- [app_store_submission_rules.md](./app_store_submission_rules.md) - Submission requirements
- [privacy_policy_requirements.md](./privacy_policy_requirements.md) - Privacy policy creation

### Master Index:
- [README.md](./README.md) - Complete documentation index

---

## 🆘 Common First Commit Issues

### Issue: "Privacy Manifest not found"
**Solution:** Make sure file is added to app target, not test targets.

### Issue: "Xcode version too old"
**Solution:** Update to Xcode 16+ from Mac App Store.

### Issue: "Don't know what to put in Privacy Manifest"
**Solution:** Use the exact template in `privacy_manifest_requirements.md` Section 3.

### Issue: "Where do I add medical disclaimer?"
**Solution:** For now, add it as a comment in your main App file. Implement UI in Phase 4 (Onboarding).

---

## 💡 Pro Tips

1. **Commit early, commit often** - Small commits are easier to review
2. **Follow MVVM strictly** - Saves refactoring time later
3. **Add SwiftUI previews** - Makes development much faster
4. **Test on real device** - Simulator doesn't catch everything
5. **Read health rules twice** - Medical app rejections are common

---

## 📞 Need Help?

**Stuck on something?** Check these resources:

1. **Privacy Manifest issues:** `privacy_manifest_requirements.md`
2. **Health compliance questions:** `health_app_compliance_rules.md`
3. **Architecture questions:** `AIrules.md`
4. **Apple documentation:** [developer.apple.com](https://developer.apple.com)

---

## ⏱️ Time Estimate

**Total time for first commit setup:** ~1 hour

- Privacy Manifest: 15 min
- Medical disclaimer: 10 min
- Xcode verification: 2 min
- Project structure: 5 min
- Info.plist: 5 min
- Reading rules: 20 min
- Testing & verification: 5 min

---

**Ready to start?** Begin with item #1 (Privacy Manifest) and work through the checklist!

**Questions?** All answers are in the `rules/` directory. Use `README.md` as your guide.

---

*Last updated: October 5, 2025*
