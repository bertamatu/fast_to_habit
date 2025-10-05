# Privacy Manifest Requirements (Oct 2025)

## Overview
Starting in 2025, Apple requires all apps to include a **Privacy Manifest file** (`PrivacyInfo.xcprivacy`) that declares data collection practices and API usage reasons.

## 1. Privacy Manifest File Location
- File name: `PrivacyInfo.xcprivacy`
- Location: Add to your app's main bundle (root of your Xcode project)
- Format: Property list (XML/plist format)

## 2. Required Sections

### A. NSPrivacyTracking
Declare whether your app or third-party SDKs use data for tracking purposes.
```xml
<key>NSPrivacyTracking</key>
<false/>
```
**For Fast To Habit:** Set to `false` (no tracking in MVP)

### B. NSPrivacyTrackingDomains
List domains used for tracking (if NSPrivacyTracking is true).
```xml
<key>NSPrivacyTrackingDomains</key>
<array>
    <!-- Empty for MVP - no tracking -->
</array>
```

### C. NSPrivacyCollectedDataTypes
Declare ALL data types your app collects.

**For Fast To Habit MVP:**
```xml
<key>NSPrivacyCollectedDataTypes</key>
<array>
    <dict>
        <key>NSPrivacyCollectedDataType</key>
        <string>NSPrivacyCollectedDataTypeHealthAndFitness</string>
        <key>NSPrivacyCollectedDataTypeLinked</key>
        <false/>
        <key>NSPrivacyCollectedDataTypeTracking</key>
        <false/>
        <key>NSPrivacyCollectedDataTypePurposes</key>
        <array>
            <string>NSPrivacyCollectedDataTypePurposeAppFunctionality</string>
        </array>
    </dict>
    <dict>
        <key>NSPrivacyCollectedDataType</key>
        <string>NSPrivacyCollectedDataTypeOtherUsageData</string>
        <key>NSPrivacyCollectedDataTypeLinked</key>
        <false/>
        <key>NSPrivacyCollectedDataTypeTracking</key>
        <false/>
        <key>NSPrivacyCollectedDataTypePurposes</key>
        <array>
            <string>NSPrivacyCollectedDataTypePurposeAppFunctionality</string>
        </array>
    </dict>
</array>
```

**Data types we collect:**
- **Health & Fitness**: Fasting session data (start/end times, duration)
- **Other Usage Data**: App preferences, notification settings

### D. NSPrivacyAccessedAPITypes (Required Reason APIs)
Declare APIs that require approved reasons.

**Common APIs Fast To Habit uses:**

#### UserDefaults (for onboarding tracking, settings)
```xml
<key>NSPrivacyAccessedAPITypes</key>
<array>
    <dict>
        <key>NSPrivacyAccessedAPIType</key>
        <string>NSPrivacyAccessedAPICategoryUserDefaults</string>
        <key>NSPrivacyAccessedAPITypeReasons</key>
        <array>
            <string>CA92.1</string>
        </array>
    </dict>
</array>
```

**Approved reasons for UserDefaults:**
- **CA92.1**: Access info from same app, no tracking (our use case)

#### File Timestamp APIs (if using file modification dates)
```xml
<dict>
    <key>NSPrivacyAccessedAPIType</key>
    <string>NSPrivacyAccessedAPICategoryFileTimestamp</string>
    <key>NSPrivacyAccessedAPITypeReasons</key>
    <array>
        <string>C617.1</string>
    </array>
</dict>
```

**Approved reasons:**
- **C617.1**: Display to user or export (e.g., showing when data was created)
- **C617.2**: File access within app container
- **C617.3**: Access by documented API
- **C617.4**: Access by documented API for file coordination

## 3. Complete Privacy Manifest Template for Fast To Habit

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Tracking -->
    <key>NSPrivacyTracking</key>
    <false/>
    
    <key>NSPrivacyTrackingDomains</key>
    <array/>
    
    <!-- Data Collection -->
    <key>NSPrivacyCollectedDataTypes</key>
    <array>
        <!-- Health & Fitness Data -->
        <dict>
            <key>NSPrivacyCollectedDataType</key>
            <string>NSPrivacyCollectedDataTypeHealthAndFitness</string>
            <key>NSPrivacyCollectedDataTypeLinked</key>
            <false/>
            <key>NSPrivacyCollectedDataTypeTracking</key>
            <false/>
            <key>NSPrivacyCollectedDataTypePurposes</key>
            <array>
                <string>NSPrivacyCollectedDataTypePurposeAppFunctionality</string>
            </array>
        </dict>
        <!-- Usage Data -->
        <dict>
            <key>NSPrivacyCollectedDataType</key>
            <string>NSPrivacyCollectedDataTypeOtherUsageData</string>
            <key>NSPrivacyCollectedDataTypeLinked</key>
            <false/>
            <key>NSPrivacyCollectedDataTypeTracking</key>
            <false/>
            <key>NSPrivacyCollectedDataTypePurposes</key>
            <array>
                <string>NSPrivacyCollectedDataTypePurposeAppFunctionality</string>
            </array>
        </dict>
    </array>
    
    <!-- Required Reason APIs -->
    <key>NSPrivacyAccessedAPITypes</key>
    <array>
        <!-- UserDefaults -->
        <dict>
            <key>NSPrivacyAccessedAPIType</key>
            <string>NSPrivacyAccessedAPICategoryUserDefaults</string>
            <key>NSPrivacyAccessedAPITypeReasons</key>
            <array>
                <string>CA92.1</string>
            </array>
        </dict>
        <!-- File Timestamps (if needed) -->
        <dict>
            <key>NSPrivacyAccessedAPIType</key>
            <string>NSPrivacyAccessedAPICategoryFileTimestamp</string>
            <key>NSPrivacyAccessedAPITypeReasons</key>
            <array>
                <string>C617.1</string>
            </array>
        </dict>
    </array>
</dict>
</plist>
```

## 4. Third-Party SDK Requirements

**Rule:** Before adding ANY third-party SDK, verify it includes a Privacy Manifest.

**How to check:**
1. Look for `PrivacyInfo.xcprivacy` file in the SDK package
2. Check SDK documentation for privacy manifest compliance
3. Verify SDK is updated for 2025 requirements

**SDKs that require Privacy Manifests (common examples):**
- Analytics SDKs (Firebase, Mixpanel, etc.)
- Ad networks
- Crash reporting tools
- Social media SDKs

**Fast To Habit MVP:** No third-party SDKs (good!)

## 5. Testing & Validation

### Pre-commit Checklist:
- [ ] `PrivacyInfo.xcprivacy` file exists in project root
- [ ] File is added to app target (not test targets)
- [ ] NSPrivacyTracking set correctly (false for MVP)
- [ ] All collected data types declared
- [ ] All Required Reason APIs declared with approved reasons
- [ ] No third-party SDKs without Privacy Manifests
- [ ] Build succeeds without privacy warnings

### Xcode Validation:
1. Build your app in Xcode 16+
2. Check for privacy-related warnings in build log
3. Use Xcode's Privacy Report (Product > Privacy Report)

### App Store Connect Validation:
1. Upload build to App Store Connect
2. Check for ITMS-91053 errors (missing required reasons)
3. Verify no privacy manifest warnings

## 6. Common Required Reason API Categories

| API Category | When to Declare | Common Reasons |
|--------------|----------------|----------------|
| **UserDefaults** | Using UserDefaults, NSUserDefaults | CA92.1 (same app, no tracking) |
| **File Timestamp** | Accessing file creation/modification dates | C617.1 (display to user) |
| **System Boot Time** | Accessing system uptime | 35F9.1 (measure time in app) |
| **Disk Space** | Checking available storage | E174.1 (display to user) |
| **Active Keyboards** | Accessing keyboard list | 3EC4.1 (custom keyboard functionality) |

## 7. Data Not Linked to User Identity

**For Fast To Habit:** All data is stored locally on device using SwiftData.
- No user accounts
- No server sync
- No cross-device tracking
- Data never leaves the device

**Therefore:** Set `NSPrivacyCollectedDataTypeLinked` to `false` for all data types.

## 8. Future Considerations

### When adding iCloud sync:
- Update Privacy Manifest to include iCloud data sync
- Declare data synchronization purposes
- Update Privacy Nutrition Labels

### When adding HealthKit:
- Add HealthKit data type declarations
- Follow health-specific privacy rules
- Cannot use health data for advertising

### When adding analytics:
- Verify analytics SDK has Privacy Manifest
- Declare analytics data collection
- Update tracking status if needed

## 9. Resources

- [Apple Privacy Manifest Documentation](https://developer.apple.com/documentation/bundleresources/privacy-manifest-files)
- [Required Reason API List](https://developer.apple.com/documentation/bundleresources/privacy-manifest-files/describing-use-of-required-reason-api)
- [Privacy Nutrition Labels Guide](https://developer.apple.com/app-store/app-privacy-details/)

## 10. Pre-commit Validation Script

Add to your pre-commit checklist:

```bash
# Check if Privacy Manifest exists
if [ ! -f "FastToHabit/PrivacyInfo.xcprivacy" ]; then
    echo "❌ ERROR: PrivacyInfo.xcprivacy not found!"
    exit 1
fi

# Check if file is in git
if ! git ls-files --error-unmatch FastToHabit/PrivacyInfo.xcprivacy > /dev/null 2>&1; then
    echo "⚠️  WARNING: PrivacyInfo.xcprivacy not tracked in git"
fi

echo "✅ Privacy Manifest found"
```

## 11. Action Items for First Commit

- [ ] Create `PrivacyInfo.xcprivacy` file in Xcode project root
- [ ] Add file to app target (not test targets)
- [ ] Copy template from Section 3 above
- [ ] Customize for your specific data collection
- [ ] Build and verify no privacy warnings
- [ ] Add to version control
- [ ] Document in commit message

