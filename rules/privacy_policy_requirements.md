# Privacy Policy Requirements (Oct 2025)

## Overview
Apple requires ALL apps to have a publicly accessible privacy policy. This document outlines what must be included and how to create one for Fast To Habit.

## 1. Apple Requirements

### Mandatory Elements (App Review 5.1.1):

1. **Privacy Policy URL**
   - Must be publicly accessible (no login required)
   - Must be provided in App Store Connect
   - Must be accessible within the app

2. **Privacy Policy Content Must:**
   - Identify what data is collected
   - Explain how data is collected
   - Describe all uses of that data
   - Explain data retention/deletion policies
   - Describe how users can revoke consent or request deletion
   - List any third parties with access to user data

3. **Third-Party Data Sharing:**
   - Confirm third parties provide equal protection
   - List all third-party SDKs and services
   - Explain what data is shared with them

## 2. Required Privacy Policy Sections

### Section 1: Introduction
- App name and purpose
- Commitment to privacy
- Last updated date
- Contact information

### Section 2: Data We Collect

**For Fast To Habit MVP:**

```markdown
## Information We Collect

Fast To Habit collects and stores the following information locally on your device:

### Fasting Data
- Fasting session start and end times
- Fasting duration and history
- Fasting goals and preferences

### Supplement Information
- Supplement names and descriptions
- Dosage information (as entered by you)
- Reminder schedules and timing
- Supplement intake history

### App Usage Data
- App preferences and settings
- Notification preferences
- Onboarding completion status
- Theme preferences (dark/light mode)

### Data NOT Collected
We do NOT collect:
- Personal identification information (name, email, phone)
- Location data
- Contact information
- Photos or media
- Financial information
- Browsing history
- Device identifiers for tracking
```

### Section 3: How We Use Your Data

```markdown
## How We Use Your Information

Your data is used solely for the following purposes:

### App Functionality
- Display your fasting progress and history
- Send supplement reminders at scheduled times
- Track your wellness habits and streaks
- Provide personalized app experience

### Local Storage Only
- All data is stored locally on your device using Apple's SwiftData
- Data never leaves your device
- No cloud synchronization in current version
- No data transmission to external servers

### No Advertising or Marketing
- We do NOT use your health data for advertising
- We do NOT sell your data to third parties
- We do NOT share your data with data brokers
- We do NOT track you across other apps or websites
```

### Section 4: Data Storage and Security

```markdown
## Data Storage and Security

### Local Storage
- All data is stored securely on your device using SwiftData
- Data is protected by your device's security features (passcode, Face ID, Touch ID)
- Data is included in your device's encrypted backups

### No Cloud Storage
- We do NOT store your data on external servers
- We do NOT use iCloud for health data storage
- Your data remains private and under your control

### Data Backup
- Your data is included in your device's local and iCloud backups
- Backup data is encrypted by Apple
- We do not have access to your backup data
```

### Section 5: Data Sharing

```markdown
## Data Sharing and Third Parties

### No Third-Party Sharing
Fast To Habit does NOT share your data with third parties.

### No Third-Party SDKs
The current version does not include:
- Analytics services
- Advertising networks
- Social media integrations
- Crash reporting tools

### Future Third-Party Services
If we add third-party services in the future:
- We will update this privacy policy
- We will notify you of changes
- You will have the option to opt out
- Third parties will be required to protect your data equally
```

### Section 6: Your Privacy Rights

```markdown
## Your Privacy Rights

### Data Access
You have full access to all your data within the app at any time.

### Data Deletion
You can delete your data at any time:
- Delete individual fasting sessions or supplements
- Clear all data from Settings
- Uninstall the app to remove all data

### Data Export
You can export your data:
- [Future feature: Export to CSV/PDF]
- Share data with your healthcare provider
- Transfer data to another device via backup

### Consent Withdrawal
You can withdraw consent for notifications:
- Disable notifications in iOS Settings
- Disable specific reminder types in app Settings

### Data Portability
Your data is stored in standard formats and can be accessed or exported upon request.
```

### Section 7: Children's Privacy

```markdown
## Children's Privacy

Fast To Habit is not intended for children under 13 years of age.

We do not knowingly collect personal information from children under 13. 
If you are a parent or guardian and believe your child has provided us 
with personal information, please contact us.

For users aged 13-17, we recommend parental guidance when using health 
and wellness apps.
```

### Section 8: Health Data Specific

```markdown
## Health and Fitness Data

### Medical Disclaimer
Fast To Habit is a wellness tracking tool, not a medical device. 
The app does not provide medical advice, diagnosis, or treatment.

### Health Data Usage
- Your fasting and supplement data is considered health information
- We treat this data with the highest level of privacy protection
- Health data is NEVER used for advertising or marketing
- Health data is NEVER shared with third parties
- Health data remains on your device

### HealthKit Integration (Future)
If we add HealthKit integration:
- We will request your explicit permission
- We will clearly explain what data we access
- You can revoke permission at any time in iOS Settings
- HealthKit data will follow the same privacy protections
```

### Section 9: Notifications

```markdown
## Notifications and Permissions

### Notification Permission
We request notification permission to:
- Send supplement reminders at scheduled times
- Notify you when fasting periods end
- Provide motivational messages (optional)

### How We Use Notifications
- Notifications are generated locally on your device
- No notification data is sent to external servers
- You can disable notifications at any time in iOS Settings

### Notification Content
- Notifications contain only information you entered
- We do not include sensitive health information in notifications
- You can customize notification content and timing
```

### Section 10: Changes to Privacy Policy

```markdown
## Changes to This Privacy Policy

We may update this privacy policy from time to time. Changes will be 
reflected by updating the "Last Updated" date at the top of this policy.

### Notification of Changes
- Material changes will be announced in the app
- You will be prompted to review updated policy
- Continued use of the app constitutes acceptance of changes

### Version History
- Version 1.0 - [Date] - Initial release
```

### Section 11: Legal Compliance

```markdown
## Legal Compliance

### GDPR Compliance (EU Users)
If you are in the European Union, you have additional rights:
- Right to access your personal data
- Right to rectification of inaccurate data
- Right to erasure ("right to be forgotten")
- Right to restrict processing
- Right to data portability
- Right to object to processing

### CCPA Compliance (California Users)
If you are a California resident, you have the right to:
- Know what personal information is collected
- Know whether personal information is sold or disclosed
- Say no to the sale of personal information
- Access your personal information
- Request deletion of personal information
- Not be discriminated against for exercising your rights

### Data Retention
- We retain your data only as long as you use the app
- You can delete data at any time
- Uninstalling the app removes all data from your device
```

### Section 12: Contact Information

```markdown
## Contact Us

If you have questions about this privacy policy or your data:

**Email:** [your-email@example.com]
**Website:** [your-website.com]
**Response Time:** We aim to respond within 48 hours

For data deletion requests, please contact us at [privacy@example.com]
```

## 3. Privacy Policy Hosting Options

### Option 1: GitHub Pages (Free)
- Create a repository for your privacy policy
- Use GitHub Pages to host it
- URL: `https://yourusername.github.io/fast-to-habit-privacy`

### Option 2: Simple Website
- Use a simple static site generator
- Host on Netlify, Vercel, or similar (free tier)
- Custom domain optional

### Option 3: App Website
- Include privacy policy on your app's website
- URL: `https://yourapp.com/privacy`

### Option 4: Notion/Google Docs (Not Recommended)
- Publicly accessible but less professional
- May not meet Apple's standards for "publicly accessible"

## 4. In-App Privacy Policy Access

### Implementation Requirements:

1. **Settings Screen:**
```swift
Section("Legal") {
    Link("Privacy Policy", destination: URL(string: "https://yourapp.com/privacy")!)
    Link("Terms of Service", destination: URL(string: "https://yourapp.com/terms")!)
}
```

2. **Onboarding Screen:**
```swift
Text("By continuing, you agree to our [Privacy Policy](https://yourapp.com/privacy) and [Terms of Service](https://yourapp.com/terms)")
    .font(.caption)
    .foregroundColor(.secondary)
```

3. **About Screen:**
```swift
VStack(alignment: .leading, spacing: 12) {
    Text("Fast To Habit v1.0")
    Link("Privacy Policy", destination: URL(string: "https://yourapp.com/privacy")!)
    Link("Terms of Service", destination: URL(string: "https://yourapp.com/terms")!)
}
```

## 5. App Store Connect Configuration

### Where to Add Privacy Policy URL:

1. Log in to App Store Connect
2. Select your app
3. Go to "App Information"
4. Scroll to "Privacy Policy URL"
5. Enter your publicly accessible URL
6. Save changes

**Important:** URL must be accessible without login and work on all devices.

## 6. Privacy Nutrition Labels (App Store Connect)

### Data Types to Declare for Fast To Habit:

| Data Type | Linked to User? | Used for Tracking? | Purpose |
|-----------|-----------------|-------------------|---------|
| Health & Fitness | No | No | App Functionality |
| Other Usage Data | No | No | App Functionality |

### Detailed Declarations:

**Health & Fitness:**
- Fasting data (start/end times, duration)
- Supplement schedules and intake history
- Purpose: App Functionality
- Not linked to identity (local storage only)
- Not used for tracking

**Other Usage Data:**
- App preferences and settings
- Notification preferences
- Purpose: App Functionality
- Not linked to identity
- Not used for tracking

## 7. Privacy Policy Template (Complete)

See separate file: `privacy_policy_template.md` (to be created)

## 8. Pre-commit Checklist

- [ ] Privacy policy written and reviewed
- [ ] Privacy policy hosted at public URL
- [ ] URL accessible without login
- [ ] URL works on mobile devices
- [ ] Privacy policy URL added to App Store Connect
- [ ] In-app links to privacy policy implemented
- [ ] Privacy policy link in onboarding
- [ ] Privacy policy link in Settings
- [ ] Privacy Nutrition Labels completed in App Store Connect
- [ ] All data types declared accurately
- [ ] Third-party data sharing section accurate (none for MVP)
- [ ] Contact information included
- [ ] Last updated date included
- [ ] Legal compliance sections included (GDPR/CCPA)

## 9. Maintenance Schedule

### When to Update Privacy Policy:

- ✅ Adding third-party SDKs or services
- ✅ Changing data collection practices
- ✅ Adding cloud sync or server features
- ✅ Adding analytics or crash reporting
- ✅ Adding social features or user accounts
- ✅ Integrating with HealthKit
- ✅ Adding data export features
- ✅ Changing data retention policies

### Update Process:
1. Update privacy policy document
2. Update "Last Updated" date
3. Update Privacy Nutrition Labels in App Store Connect
4. Notify users in app (if material changes)
5. Prompt users to review updated policy

## 10. Common Mistakes to Avoid

❌ **Don't:**
- Copy/paste generic templates without customization
- Claim you don't collect data when you do
- Forget to update when adding features
- Use vague language like "we may collect"
- Hide privacy policy behind login
- Use broken or temporary URLs

✅ **Do:**
- Be specific about what data you collect
- Be honest and transparent
- Use clear, simple language
- Keep policy up to date
- Make it easily accessible
- Include contact information

## 11. Resources

- [Apple Privacy Policy Guidelines](https://developer.apple.com/app-store/review/guidelines/#privacy)
- [GDPR Compliance Guide](https://gdpr.eu/)
- [CCPA Compliance Guide](https://oag.ca.gov/privacy/ccpa)
- [Privacy Policy Generator Tools](https://www.freeprivacypolicy.com/)

## 12. Action Items for First Commit

- [ ] Write privacy policy using template above
- [ ] Choose hosting solution (GitHub Pages recommended)
- [ ] Host privacy policy at public URL
- [ ] Test URL accessibility on mobile
- [ ] Add privacy policy URL to App Store Connect
- [ ] Implement in-app privacy policy links
- [ ] Complete Privacy Nutrition Labels
- [ ] Review and verify all information is accurate
- [ ] Add to version control (if using GitHub Pages)

