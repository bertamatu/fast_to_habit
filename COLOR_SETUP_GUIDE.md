# Color Setup Guide for Assets.xcassets

**Time Required:** 15 minutes  
**Location:** Xcode → Assets.xcassets  
**Palette:** Modern iOS Health & Wellness

## 🎨 Color Values Reference

Use these exact values when creating color sets in Xcode.  
**This palette follows iOS 17/18 design trends** with health-focused colors.

---

## Step-by-Step Instructions

### 1. Open Assets.xcassets in Xcode
1. Open `FastToHabit.xcodeproj` in Xcode
2. In Project Navigator, click on `Assets.xcassets`

### 2. Create Color Sets

For each color below, follow these steps:
1. Right-click in Assets.xcassets
2. Select "New Color Set"
3. Name it exactly as shown (e.g., "BrandPrimary")
4. Click on the color square
5. In Attributes Inspector (right panel):
   - Set "Appearances" to "Any, Dark"
   - Set light mode color (Any Appearance)
   - Set dark mode color (Dark Appearance)

---

## 📋 Colors to Create

### Brand Colors

#### **BrandPrimary**
- **Light Mode:** #0A7EA4 (RGB: 10, 126, 164)
- **Dark Mode:** #64D2FF (RGB: 100, 210, 255)
- **Usage:** Primary brand color, fasting features, timer
- **Inspiration:** iOS Health app teal

#### **BrandSecondary**
- **Light Mode:** #8B5CF6 (RGB: 139, 92, 246)
- **Dark Mode:** #A78BFA (RGB: 167, 139, 250)
- **Usage:** Secondary brand color, supplement features
- **Inspiration:** iOS Fitness+ purple

#### **BrandAccent**
- **Light Mode:** #10B981 (RGB: 16, 185, 129)
- **Dark Mode:** #34D399 (RGB: 52, 211, 153)
- **Usage:** CTAs, important actions, highlights
- **Inspiration:** Fresh mint green

---

### Semantic Colors

#### **FastingActive**
- **Light Mode:** #0A7EA4 (RGB: 10, 126, 164)
- **Dark Mode:** #64D2FF (RGB: 100, 210, 255)
- **Usage:** Active fasting state indicator

#### **FastingComplete**
- **Light Mode:** #059669 (RGB: 5, 150, 105)
- **Dark Mode:** #10B981 (RGB: 16, 185, 129)
- **Usage:** Completed fasting sessions

#### **SupplementReminder**
- **Light Mode:** #8B5CF6 (RGB: 139, 92, 246)
- **Dark Mode:** #A78BFA (RGB: 167, 139, 250)
- **Usage:** Supplement reminder notifications

#### **SupplementComplete**
- **Light Mode:** #059669 (RGB: 5, 150, 105)
- **Dark Mode:** #10B981 (RGB: 16, 185, 129)
- **Usage:** Supplement taken/completed

---

### Status Colors

#### **Success**
- **Light Mode:** #059669 (RGB: 5, 150, 105)
- **Dark Mode:** #10B981 (RGB: 16, 185, 129)
- **Usage:** Success messages, completed states

#### **Warning**
- **Light Mode:** #F59E0B (RGB: 245, 158, 11)
- **Dark Mode:** #FBBF24 (RGB: 251, 191, 36)
- **Usage:** Warning messages, reminders

#### **Error**
- **Light Mode:** #EF4444 (RGB: 239, 68, 68)
- **Dark Mode:** #F87171 (RGB: 248, 113, 113)
- **Usage:** Error messages, alerts

#### **Info**
- **Light Mode:** #0A7EA4 (RGB: 10, 126, 164)
- **Dark Mode:** #64D2FF (RGB: 100, 210, 255)
- **Usage:** Informational messages
---

### UI Colors

#### **BackgroundPrimary**
- **Light Mode:** #F9FAFB (RGB: 249, 250, 251)
- **Dark Mode:** #111827 (RGB: 17, 24, 39)
- **Usage:** Main screen background (OLED-friendly dark)

#### **BackgroundSecondary**
- **Light Mode:** #FFFFFF (RGB: 255, 255, 255)
- **Dark Mode:** #1F2937 (RGB: 31, 41, 55)
- **Usage:** Card backgrounds, elevated surfaces

#### **BackgroundTertiary**
- **Light Mode:** #F3F4F6 (RGB: 243, 244, 246)
- **Dark Mode:** #374151 (RGB: 55, 65, 81)
- **Usage:** Nested cards, input fields backgrounds

#### **CardBackground**
- **Light Mode:** #FFFFFF (RGB: 255, 255, 255)
- **Dark Mode:** #1F2937 (RGB: 31, 41, 55)
- **Usage:** Card container background

#### **TextTertiary**
- **Light Mode:** #9CA3AF (RGB: 156, 163, 175)
- **Dark Mode:** #6B7280 (RGB: 107, 114, 128)
- **Usage:** Hints, placeholders, disabled text

#### **Divider**
- **Light Mode:** #E5E7EB (RGB: 229, 231, 235)
- **Dark Mode:** #374151 (RGB: 55, 65, 81)
- **Usage:** Separators, dividers

#### **Border**
- **Light Mode:** #D1D5DB (RGB: 209, 213, 219)
- **Dark Mode:** #4B5563 (RGB: 75, 85, 99)
- **Usage:** Input borders, outlines

---

### Interactive Colors

#### **ButtonPrimary**
- **Light Mode:** #0A7EA4 (RGB: 10, 126, 164)
- **Dark Mode:** #64D2FF (RGB: 100, 210, 255)
- **Usage:** Primary button background

#### **ButtonSecondary**
- **Light Mode:** Transparent
- **Dark Mode:** Transparent
- **Usage:** Secondary button background (outlined)

#### **ButtonText**
- **Light Mode:** #FFFFFF (RGB: 255, 255, 255)
- **Dark Mode:** #FFFFFF (RGB: 255, 255, 255)
- **Usage:** Button text color

---

### Gradient Colors

#### **FastingGradientStart**
- **Light Mode:** #0A7EA4 (RGB: 10, 126, 164)
- **Dark Mode:** #64D2FF (RGB: 100, 210, 255)
- **Usage:** Fasting timer gradient start color

#### **FastingGradientEnd**
- **Light Mode:** #10B981 (RGB: 16, 185, 129)
- **Dark Mode:** #34D399 (RGB: 52, 211, 153)
- **Usage:** Fasting timer gradient end color

---

## 🎯 Quick Setup Checklist

{{ ... }}
- [ ] Create all Brand Colors (3 colors)
- [ ] Create all Semantic Colors (4 colors)
- [ ] Create all Status Colors (4 colors)
- [ ] Create all UI Colors (7 colors)
- [ ] Create all Interactive Colors (4 colors)
- [ ] Create all Gradient Colors (2 colors)
- [ ] **Total: 24 color sets**
- [ ] Test in light mode (Xcode simulator)
- [ ] Test in dark mode (Xcode simulator)
- [ ] Build and run to verify no errors

---

## 💡 Pro Tips

1. **Copy-Paste Hex Values:** Use the hex color picker in Xcode for accuracy
2. **Test Both Modes:** Toggle between light and dark mode in simulator (⌘+Shift+A)
3. **Naming Matters:** Use exact names as shown - Swift code references these
4. **Preview Colors:** Run the app and check `Colors.swift` previews

---

## 🔍 How to Enter Colors in Xcode

### Method 1: Hex Input
1. Click on color square
2. In color picker, select "RGB Sliders" tab
3. At the bottom, there's a hex input field
4. Paste hex value (e.g., #007AFF)

### Method 2: RGB Sliders
1. Click on color square
2. Select "RGB Sliders" tab
3. Enter RGB values manually (0-255 range)

---

## ✅ Verification

After creating all colors, verify by:

1. **Build the project** (⌘+B) - should have no errors
2. **Run in simulator** - colors should appear correctly
3. **Toggle dark mode** - colors should adapt
4. **Check previews** - Open `Colors.swift` and view previews

---

## 🚨 Common Issues

### "Cannot find 'BrandPrimary' in scope"
- **Solution:** Make sure color set name in Assets.xcassets matches exactly

### Colors look wrong in dark mode
- **Solution:** Verify you set both "Any Appearance" and "Dark Appearance"

### Colors not updating
- **Solution:** Clean build folder (⌘+Shift+K) and rebuild

---

## 📸 Screenshots Needed

After setup, take screenshots of:
1. Assets.xcassets showing all color sets
2. Light mode preview
3. Dark mode preview

---

**Estimated Time:** 15-20 minutes  
**Next Step:** After colors are set up, move to Step 2 (Typography)

[Rule: Design System - Color Setup]
