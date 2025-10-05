# Health App Compliance Rules (Oct 2025)

## Overview
Fast To Habit is a **health and fitness app** that tracks fasting and supplements. Apple has strict guidelines for health-related apps to protect user safety and prevent medical misinformation.

## 1. App Classification

**Fast To Habit is:**
- ✅ Health & Fitness tracking app
- ✅ Supplement reminder tool
- ✅ Personal wellness tracker

**Fast To Habit is NOT:**
- ❌ Medical device
- ❌ Diagnostic tool
- ❌ Medical advice provider
- ❌ Drug dosage calculator (restricted)

## 2. Critical Health App Guidelines (Apple Review 1.4)

### 1.4.1 Medical Apps Under Greater Scrutiny
> "Medical apps that could provide inaccurate data or information, or that could be used for diagnosing or treating patients may be reviewed with greater scrutiny."

**What this means for us:**
- Fasting timer must be accurate
- Supplement reminders must be reliable
- No false data or misleading information
- Thorough testing required

**If we had FDA clearance:** Would need to submit documentation (we don't need this for MVP)

### 1.4.2 Drug Dosage Calculators (RESTRICTED)
> "Drug dosage calculators must come from the drug manufacturer, a hospital, university, health insurance company, or other approved entity, or receive approval by the FDA."

**What this means for us:**
- ❌ CANNOT provide supplement dosage calculations
- ❌ CANNOT recommend specific supplement amounts
- ✅ CAN allow users to track their own supplement schedules
- ✅ CAN provide general educational information

**Safe approach:**
- User enters their own dosage (from their doctor/label)
- We only remind them to take it
- No automated dosage recommendations

## 3. Health Data Usage Restrictions (Apple Review 5.1.3)

### 5.1.3(i) No Advertising or Data Mining
> "Apps may not use or disclose to third parties data gathered in the health, fitness, and medical research context for advertising or other use-based data mining purposes."

**Strict rules:**
- ❌ CANNOT use fasting data for advertising
- ❌ CANNOT sell health data to third parties
- ❌ CANNOT use supplement data for marketing
- ✅ CAN use data ONLY for health management
- ✅ CAN use data for health research (with consent)

**For Fast To Habit MVP:**
- All data stays on device (SwiftData)
- No server sync = no data sharing
- No analytics on health data
- No third-party SDKs with access to health data

### 5.1.3(ii) No False Data in HealthKit
> "Apps must not write false or inaccurate data into HealthKit or any other medical research or health management apps."

**Rules:**
- ❌ CANNOT write fake/test data to HealthKit
- ❌ CANNOT manipulate health data
- ✅ MUST ensure data accuracy before writing
- ✅ MUST validate user input

**For Fast To Habit MVP:**
- Not using HealthKit yet (future feature)
- When we add it: strict validation required

### 5.1.3(iii) No Personal Health Data in iCloud
> "Apps may not store personal health information in iCloud."

**Rules:**
- ❌ CANNOT sync health data via iCloud
- ✅ CAN use local device storage (SwiftData)
- ✅ CAN use secure server with proper encryption (future)

**For Fast To Habit MVP:**
- Local storage only (compliant)
- Future: Need secure backend, not iCloud

## 4. Medical Disclaimers Required

### Required Disclaimer Locations:
1. **App Store Description**
2. **First launch / Onboarding**
3. **Settings or About section**
4. **Any screen showing health information**

### Recommended Disclaimer Text:

```
MEDICAL DISCLAIMER

Fast To Habit is a wellness tracking tool for personal use only. 
It is not intended to diagnose, treat, cure, or prevent any disease 
or medical condition.

The information provided by this app is for informational and 
educational purposes only and should not be considered medical advice.

Always consult with a qualified healthcare provider before:
- Starting any fasting regimen
- Taking dietary supplements
- Making changes to your diet or health routine
- If you have any medical conditions or concerns

This app is not a substitute for professional medical advice, 
diagnosis, or treatment.
```

### Supplement-Specific Disclaimer:

```
SUPPLEMENT INFORMATION

This app allows you to track supplements prescribed or recommended 
by your healthcare provider. We do not recommend specific supplements 
or dosages.

Always follow the guidance of your healthcare provider and the 
instructions on supplement labels.

Dietary supplements are not regulated by the FDA and may interact 
with medications or medical conditions.
```

## 5. Content Restrictions

### ❌ What We CANNOT Do:

1. **No Medical Diagnosis**
   - Cannot suggest medical conditions based on fasting patterns
   - Cannot diagnose nutritional deficiencies
   - Cannot interpret health symptoms

2. **No Treatment Recommendations**
   - Cannot prescribe fasting schedules for medical conditions
   - Cannot recommend supplements for specific health issues
   - Cannot suggest medical treatments

3. **No Dosage Calculations**
   - Cannot calculate supplement dosages
   - Cannot adjust dosages based on user data
   - Cannot recommend increasing/decreasing amounts

4. **No Medical Claims**
   - Cannot claim health benefits without scientific evidence
   - Cannot promise weight loss, disease prevention, or cures
   - Cannot make FDA-regulated claims

5. **No Misleading Information**
   - Cannot provide inaccurate health information
   - Cannot cite fake studies or research
   - Cannot misrepresent scientific consensus

### ✅ What We CAN Do:

1. **Tracking & Reminders**
   - Track fasting start/end times
   - Remind users to take supplements
   - Display fasting duration and history

2. **Educational Content (General)**
   - Explain what intermittent fasting is
   - Provide general information about common supplements
   - Link to reputable health resources (NIH, Mayo Clinic, etc.)

3. **User-Entered Data**
   - Allow users to log their own supplement schedules
   - Let users set their own fasting goals
   - Store user preferences and settings

4. **Progress Tracking**
   - Show fasting streaks and patterns
   - Display supplement adherence rates
   - Provide basic statistics (non-diagnostic)

## 6. AI Features Compliance (Future)

### If Adding AI Supplement Guidance:

**Strict requirements:**
- ❌ CANNOT provide personalized medical advice
- ❌ CANNOT diagnose deficiencies
- ❌ CANNOT recommend specific products or brands
- ✅ CAN provide general educational information
- ✅ CAN explain what supplements are commonly used for
- ✅ MUST include disclaimers on every AI response

**Safe AI approach:**
```
User: "What supplements should I take for energy?"

❌ BAD Response:
"You should take 500mg of B12 and 200mg of CoQ10 daily."

✅ GOOD Response:
"Common supplements associated with energy support include B vitamins, 
CoQ10, and iron. However, I cannot provide personalized recommendations. 
Please consult your healthcare provider to determine what's appropriate 
for your individual needs and to rule out any underlying medical conditions."
```

## 7. Research Apps (If Applicable)

**Not applicable to MVP**, but if we add research features:

### Required for Health Research Apps (5.1.3 iii-iv):

1. **Informed Consent Required:**
   - Nature, purpose, and duration of research
   - Procedures, risks, and benefits
   - Data confidentiality and handling
   - Contact for questions
   - Withdrawal process
   - Parental consent for minors

2. **Ethics Review Board Approval:**
   - Must obtain IRB (Institutional Review Board) approval
   - Proof required upon request
   - Required for all ResearchKit apps

**For Fast To Habit MVP:** Not conducting research, so not applicable.

## 8. HealthKit Integration (Future)

### When we add HealthKit:

**Required:**
- Request permission only when needed
- Clear explanation of why we need access
- Cannot write false data
- Cannot use data for advertising
- Must handle permission denial gracefully

**Recommended HealthKit data for Fast To Habit:**
- Dietary Energy (fasting periods)
- Dietary Water (hydration tracking)
- Mindful Minutes (fasting mindfulness)

**Not recommended:**
- Medical data types (requires medical clearance)
- Clinical data (restricted)

## 9. Notification Content Guidelines

### Safe Notification Examples:

✅ **Good:**
- "Time to take your Vitamin D"
- "Your 16-hour fast is complete"
- "Reminder: Evening supplements"

❌ **Bad:**
- "Take your medication now" (implies medical treatment)
- "Your deficiency requires supplements" (diagnosis)
- "Increase your dosage today" (medical advice)

## 10. App Store Metadata Guidelines

### App Name & Subtitle:
✅ **Good:**
- "Fast To Habit - Fasting Tracker"
- "Fast To Habit - Wellness & Supplements"

❌ **Bad:**
- "Fast To Habit - Medical Fasting Tool"
- "Fast To Habit - Cure Your Health"

### Description:
- Focus on tracking and reminders
- Avoid medical claims
- Include disclaimers
- Emphasize personal wellness

### Keywords to AVOID:
- Medical, diagnosis, treatment, cure, therapy
- Disease names (diabetes, obesity, etc.)
- FDA-regulated terms
- Prescription, medication

### Keywords to USE:
- Fasting, intermittent fasting, wellness
- Supplement tracker, reminder, schedule
- Health tracking, personal wellness
- Habit building, routine

## 11. Pre-commit Checklist

- [ ] No medical diagnosis features
- [ ] No treatment recommendations
- [ ] No dosage calculations or recommendations
- [ ] Medical disclaimers present in app
- [ ] No false or misleading health claims
- [ ] No health data used for advertising
- [ ] No personal health data in iCloud
- [ ] Accurate fasting timer implementation
- [ ] Reliable notification system
- [ ] Educational content is factual and sourced
- [ ] AI responses (if any) include disclaimers
- [ ] App Store metadata avoids medical claims
- [ ] Privacy policy addresses health data

## 12. Testing Requirements

### Health-Specific Testing:

1. **Accuracy Testing:**
   - Fasting timer accuracy (to the second)
   - Notification timing accuracy
   - Data persistence and integrity

2. **Safety Testing:**
   - No crashes during health data operations
   - Graceful handling of invalid input
   - Data backup and recovery

3. **Content Review:**
   - All text reviewed for medical claims
   - Disclaimers present and visible
   - Educational content fact-checked

## 13. Legal Protection

### Recommended Legal Documents:

1. **Terms of Service** - Include:
   - Limitation of liability
   - No medical advice disclaimer
   - User responsibility for health decisions
   - Indemnification clause

2. **Privacy Policy** - Include:
   - Health data handling
   - No third-party sharing
   - Data retention and deletion
   - User rights (GDPR/CCPA)

3. **EULA** - Include:
   - Acceptable use policy
   - Health disclaimer
   - Warranty disclaimer

## 14. Resources

- [Apple Health & Fitness Guidelines](https://developer.apple.com/app-store/review/guidelines/#health-and-health-research)
- [FDA Mobile Medical Apps Guidance](https://www.fda.gov/medical-devices/digital-health-center-excellence/mobile-medical-applications)
- [HealthKit Documentation](https://developer.apple.com/documentation/healthkit)
- [NIH Dietary Supplements](https://ods.od.nih.gov/)

## 15. Action Items for First Commit

- [ ] Add medical disclaimer to onboarding flow
- [ ] Add disclaimer to app description
- [ ] Review all UI text for medical claims
- [ ] Ensure no dosage calculation features
- [ ] Verify data stays on device (no iCloud)
- [ ] Test fasting timer accuracy
- [ ] Add "Not medical advice" to About screen
- [ ] Review notification content for compliance

