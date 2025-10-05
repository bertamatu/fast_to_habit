# Fast To Habit - Development Rules & Guidelines

**Last Updated:** October 5, 2025  
**iOS Version:** 18+  
**Xcode Version:** 16+

## 📚 Documentation Overview

This directory contains all development rules, guidelines, and requirements for the Fast To Habit iOS app. All documents are organized by category and priority.

---

## 🚀 Quick Start

**New to the project?** Read these in order:

1. **[AIrules.md](./AIrules.md)** - Core development guidelines and architecture
2. **[mvp_features.md](./mvp_features.md)** - Feature roadmap and development phases
3. **[health_app_compliance_rules.md](./health_app_compliance_rules.md)** - Critical health app requirements

---

## 📋 Document Index

### 🏗️ Core Development Rules

#### **[AIrules.md](./AIrules.md)**
**Purpose:** Master development guidelines for AI code generation and project architecture

**Key Topics:**
- MVVM architecture pattern
- SwiftUI + SwiftData implementation
- File structure and organization
- ViewModels and business logic
- Notifications service
- Performance optimization
- Pre-commit checklist

**When to Reference:** Every coding session, before generating new code

---

#### **[mvp_features.md](./mvp_features.md)**
**Purpose:** Feature roadmap broken into small, committable chunks

**Development Phases:**
- **Phase 1:** Core Fasting Timer ⏱️
- **Phase 2:** Supplement Planner 💊
- **Phase 3:** Daily Summary & UX Polish ✨
- **Phase 4:** Optional Enhancements (Onboarding, Settings)

**When to Reference:** Sprint planning, feature prioritization

---

### 🎨 UI/UX Guidelines

#### **[mvp_polish_UI_rules.md](./mvp_polish_UI_rules.md)**
**Purpose:** UI polish guidelines for professional app appearance

**Key Topics:**
- SF Symbols and system fonts
- Dark/light mode support
- Rounded corners and shadows
- Spacing and padding standards
- Subtle animations
- Empty states
- Haptic feedback
- Accessibility

**When to Reference:** UI implementation, design reviews

---

#### **[onboarding_view_best_practices.md](./onboarding_view_best_practices.md)**
**Purpose:** Best practices for creating effective onboarding flows

**Key Topics:**
- 3-5 screen limit
- Swipeable TabView implementation
- Progress indicators
- Call-to-action buttons
- Onboarding completion tracking
- Accessibility support

**When to Reference:** Building onboarding flow (Phase 4)

---

### 🏥 Health & Compliance (CRITICAL)

#### **[health_app_compliance_rules.md](./health_app_compliance_rules.md)** ⚠️
**Purpose:** Critical health app compliance requirements to avoid rejection

**Key Topics:**
- Medical disclaimer requirements
- What we CAN and CANNOT do
- Supplement guidance limitations
- No dosage calculations
- No medical advice
- Health data usage restrictions
- HealthKit integration rules (future)

**When to Reference:** 
- Before implementing ANY health-related feature
- Writing app descriptions
- Creating notifications
- Adding AI features

**⚠️ CRITICAL:** Read before first commit!

---

### 🔒 Privacy & Security (CRITICAL)

#### **[privacy_manifest_requirements.md](./privacy_manifest_requirements.md)** ⚠️
**Purpose:** 2025 Privacy Manifest requirements (NEW APPLE REQUIREMENT)

**Key Topics:**
- PrivacyInfo.xcprivacy file structure
- Required Reason API declarations
- Data collection documentation
- NSPrivacyTracking configuration
- UserDefaults usage reasons
- Third-party SDK vetting

**When to Reference:**
- First commit (create Privacy Manifest)
- Before adding any third-party SDK
- Before App Store submission

**⚠️ CRITICAL:** Required for App Store submission!

---

#### **[privacy_policy_requirements.md](./privacy_policy_requirements.md)** ⚠️
**Purpose:** Privacy policy requirements and template

**Key Topics:**
- Required privacy policy sections
- Data collection disclosure
- Privacy Nutrition Labels mapping
- GDPR/CCPA compliance
- In-app privacy policy links
- Hosting options

**When to Reference:**
- Creating privacy policy (before submission)
- Updating Privacy Nutrition Labels
- Adding new data collection

**⚠️ CRITICAL:** Required for App Store submission!

---

### 📱 App Store Submission

#### **[app_store_submission_rules.md](./app_store_submission_rules.md)**
**Purpose:** Comprehensive App Store submission requirements

**Key Topics:**
- Functionality and stability
- UI/UX requirements
- Onboarding and permissions
- Privacy and data handling
- Notifications
- App icons and assets
- Accessibility
- Testing requirements
- Legal compliance

**When to Reference:** Before submitting to App Store

---

#### **[pre_submission_technical_checklist.md](./pre_submission_technical_checklist.md)** ⚠️
**Purpose:** Technical checklist for App Store submission (150+ items)

**Key Sections:**
- Xcode 16 / iOS 18 SDK verification
- Privacy Manifest validation
- Code quality checks
- Device testing requirements
- Performance testing
- App Store Connect configuration
- Certificate and provisioning

**When to Reference:** 
- Before every App Store submission
- Before creating archive
- During QA testing

**⚠️ CRITICAL:** Complete ALL items before submission!

---

## 🎯 Priority Matrix

### Before First Commit
1. ✅ Read [AIrules.md](./AIrules.md)
2. ✅ Read [health_app_compliance_rules.md](./health_app_compliance_rules.md)
3. ✅ Create Privacy Manifest ([privacy_manifest_requirements.md](./privacy_manifest_requirements.md))
4. ✅ Add medical disclaimers to code

### During Development
1. 📖 Reference [mvp_features.md](./mvp_features.md) for feature priority
2. 📖 Follow [mvp_polish_UI_rules.md](./mvp_polish_UI_rules.md) for UI
3. 📖 Check [health_app_compliance_rules.md](./health_app_compliance_rules.md) for any health-related features

### Before App Store Submission
1. ✅ Complete [pre_submission_technical_checklist.md](./pre_submission_technical_checklist.md)
2. ✅ Create privacy policy ([privacy_policy_requirements.md](./privacy_policy_requirements.md))
3. ✅ Verify [app_store_submission_rules.md](./app_store_submission_rules.md) compliance
4. ✅ Final review of [health_app_compliance_rules.md](./health_app_compliance_rules.md)

---

## 🚨 Critical Requirements for 2025

### NEW in October 2025:
1. **Xcode 16 + iOS 18 SDK** - Must build with latest tools
2. **Privacy Manifest File** - `PrivacyInfo.xcprivacy` required
3. **Required Reason APIs** - Must declare UserDefaults usage, etc.
4. **Privacy Nutrition Labels** - More detailed than before
5. **Age Rating Updates** - New questionnaire by Jan 2026

### Health App Specific:
1. **Medical Disclaimers** - Required in app and App Store
2. **No Dosage Calculations** - Restricted to approved entities
3. **No Health Data for Ads** - Strict prohibition
4. **No Health Data in iCloud** - Use local storage only

---

## 📊 Document Status

| Document | Status | Last Updated | Priority |
|----------|--------|--------------|----------|
| AIrules.md | ✅ Complete | Oct 2025 | HIGH |
| mvp_features.md | ✅ Complete | Oct 2025 | HIGH |
| mvp_polish_UI_rules.md | ✅ Complete | Oct 2025 | MEDIUM |
| onboarding_view_best_practices.md | ✅ Complete | Oct 2025 | MEDIUM |
| health_app_compliance_rules.md | ✅ Complete | Oct 2025 | CRITICAL |
| privacy_manifest_requirements.md | ✅ Complete | Oct 2025 | CRITICAL |
| privacy_policy_requirements.md | ✅ Complete | Oct 2025 | CRITICAL |
| app_store_submission_rules.md | ✅ Complete | Oct 2025 | HIGH |
| pre_submission_technical_checklist.md | ✅ Complete | Oct 2025 | CRITICAL |

---

## 🔄 Maintenance Schedule

### Review Frequency:
- **Monthly:** Check for Apple guideline updates
- **Before Each Release:** Review all CRITICAL documents
- **After iOS Updates:** Update SDK requirements
- **After Guideline Changes:** Update compliance documents

### Update Triggers:
- ✅ Apple announces new requirements
- ✅ Adding new features (HealthKit, iCloud, etc.)
- ✅ Adding third-party SDKs
- ✅ Changing data collection practices
- ✅ App Store rejection (update relevant docs)

---

## 🛠️ Tools & Resources

### Apple Official Resources:
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [Privacy Manifest Documentation](https://developer.apple.com/documentation/bundleresources/privacy-manifest-files)
- [Health & Fitness Guidelines](https://developer.apple.com/app-store/review/guidelines/#health-and-health-research)

### Development Tools:
- Xcode 16+ (required)
- iOS 18 SDK (required)
- SwiftData (data persistence)
- SwiftUI (UI framework)
- Instruments (performance testing)

### Testing Resources:
- TestFlight (beta testing)
- Xcode Previews (UI testing)
- Accessibility Inspector (a11y testing)
- Network Link Conditioner (performance testing)

---

## 📞 Support & Questions

### Internal Team:
- **Architecture Questions:** Reference [AIrules.md](./AIrules.md)
- **Feature Priority:** Reference [mvp_features.md](./mvp_features.md)
- **Compliance Questions:** Reference [health_app_compliance_rules.md](./health_app_compliance_rules.md)

### External Resources:
- **App Review Support:** [Apple Developer Support](https://developer.apple.com/support/app-review/)
- **Technical Support:** [Apple Developer Forums](https://developer.apple.com/forums/)
- **Privacy Questions:** [Privacy Support](https://developer.apple.com/support/privacy/)

---

## ✅ Pre-Commit Checklist (Quick Reference)

Before every commit, verify:

- [ ] Code follows MVVM architecture ([AIrules.md](./AIrules.md))
- [ ] No medical claims or advice ([health_app_compliance_rules.md](./health_app_compliance_rules.md))
- [ ] Privacy Manifest updated if needed ([privacy_manifest_requirements.md](./privacy_manifest_requirements.md))
- [ ] UI follows polish guidelines ([mvp_polish_UI_rules.md](./mvp_polish_UI_rules.md))
- [ ] SwiftUI previews included
- [ ] Accessibility labels added
- [ ] No debug code or print statements
- [ ] Tests pass (if applicable)
- [ ] Documentation comments added

---

## 📝 Version History

### v1.0 - October 5, 2025
- Initial documentation set
- Added 2025 Privacy Manifest requirements
- Added health app compliance rules
- Added pre-submission technical checklist
- Organized all rules into structured format

---

## 🎓 Learning Path

**For New Developers:**

1. **Week 1:** Read AIrules.md, mvp_features.md, health_app_compliance_rules.md
2. **Week 2:** Implement Phase 1 features following guidelines
3. **Week 3:** Review UI polish rules and apply to existing code
4. **Week 4:** Create Privacy Manifest and privacy policy

**For Code Review:**

1. Verify MVVM pattern compliance
2. Check for medical claims or advice
3. Verify accessibility implementation
4. Check privacy compliance
5. Verify UI polish standards

---

## 🚀 Getting Started Commands

```bash
# Navigate to rules directory
cd /Users/berta/Documents/projects/ios/FAST_TO_HABIT/2025_10_05/FastToHabit/rules

# Read all rules (macOS)
open README.md

# Search for specific topic
grep -r "Privacy Manifest" .

# Validate Privacy Manifest
plutil -lint ../FastToHabit/PrivacyInfo.xcprivacy
```

---

## 📌 Quick Links

- [Project Root](../)
- [Source Code](../FastToHabit/)
- [Tests](../FastToHabitTests/)
- [Xcode Project](../FastToHabit.xcodeproj/)

---

**Remember:** When in doubt, refer to the documentation. These rules exist to ensure a successful App Store launch and maintain code quality.

**Questions?** Update this README or create a new rule document as needed.

---

*This documentation is maintained by the Fast To Habit development team.*  
*Last reviewed: October 5, 2025*
