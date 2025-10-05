# Color Setup Guide for Assets.xcassets

**Time Required:** 15 minutes  
**Location:** Xcode → Assets.xcassets

## 🎨 Color Values Reference

Use these exact values when creating color sets in Xcode.

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
- **Light Mode:** #007AFF (RGB: 0, 122, 255)
- **Dark Mode:** #0A84FF (RGB: 10, 132, 255)
- **Usage:** Primary brand color, fasting features

#### **BrandSecondary**
- **Light Mode:** #AF52DE (RGB: 175, 82, 222)
- **Dark Mode:** #BF5AF2 (RGB: 191, 90, 242)
- **Usage:** Secondary brand color, supplement features

#### **BrandAccent**
- **Light Mode:** #007AFF (RGB: 0, 122, 255)
- **Dark Mode:** #0A84FF (RGB: 10, 132, 255)
- **Usage:** CTAs, important actions

---

### Semantic Colors

#### **FastingActive**
- **Light Mode:** #007AFF (RGB: 0, 122, 255)
- **Dark Mode:** #0A84FF (RGB: 10, 132, 255)
- **Usage:** Active fasting state indicator

#### **FastingComplete**
- **Light Mode:** #34C759 (RGB: 52, 199, 89)
- **Dark Mode:** #30D158 (RGB: 48, 209, 88)
- **Usage:** Completed fasting sessions

#### **SupplementReminder**
- **Light Mode:** #AF52DE (RGB: 175, 82, 222)
- **Dark Mode:** #BF5AF2 (RGB: 191, 90, 242)
- **Usage:** Supplement reminder notifications

#### **SupplementComplete**
- **Light Mode:** #34C759 (RGB: 52, 199, 89)
- **Dark Mode:** #30D158 (RGB: 48, 209, 88)
- **Usage:** Supplement taken/completed

---

### Status Colors

#### **Success**
- **Light Mode:** #34C759 (RGB: 52, 199, 89)
- **Dark Mode:** #30D158 (RGB: 48, 209, 88)
- **Usage:** Success messages, completed states

#### **Warning**
- **Light Mode:** #FF9500 (RGB: 255, 149, 0)
- **Dark Mode:** #FF9F0A (RGB: 255, 159, 10)
- **Usage:** Warning messages, reminders

#### **Error**
- **Light Mode:** #FF3B30 (RGB: 255, 59, 48)
- **Dark Mode:** #FF453A (RGB: 255, 69, 58)
- **Usage:** Error messages, alerts

#### **Info**
- **Light Mode:** #007AFF (RGB: 0, 122, 255)
- **Dark Mode:** #0A84FF (RGB: 10, 132, 255)
- **Usage:** Informational messages

---

### UI Colors

#### **BackgroundPrimary**
- **Light Mode:** #FFFFFF (RGB: 255, 255, 255) - White
- **Dark Mode:** #000000 (RGB: 0, 0, 0) - Black
- **Usage:** Main background

#### **BackgroundSecondary**
- **Light Mode:** #F2F2F7 (RGB: 242, 242, 247)
- **Dark Mode:** #1C1C1E (RGB: 28, 28, 30)
- **Usage:** Cards, elevated surfaces

#### **BackgroundTertiary**
- **Light Mode:** #FFFFFF (RGB: 255, 255, 255)
- **Dark Mode:** #2C2C2E (RGB: 44, 44, 46)
- **Usage:** Nested cards, grouped backgrounds

#### **CardBackground**
- **Light Mode:** #FFFFFF (RGB: 255, 255, 255)
- **Dark Mode:** #1C1C1E (RGB: 28, 28, 30)
- **Usage:** Card components

#### **TextTertiary**
- **Light Mode:** #8E8E93 (RGB: 142, 142, 147)
- **Dark Mode:** #8E8E93 (RGB: 142, 142, 147)
- **Usage:** Hints, placeholders, less important text

#### **Divider**
- **Light Mode:** #C6C6C8 (RGB: 198, 198, 200)
- **Dark Mode:** #38383A (RGB: 56, 56, 58)
- **Usage:** Separators, dividers

#### **Border**
- **Light Mode:** #D1D1D6 (RGB: 209, 209, 214)
- **Dark Mode:** #48484A (RGB: 72, 72, 74)
- **Usage:** Borders, outlines

---

### Interactive Colors

#### **ButtonPrimary**
- **Light Mode:** #007AFF (RGB: 0, 122, 255)
- **Dark Mode:** #0A84FF (RGB: 10, 132, 255)
- **Usage:** Primary button background

#### **ButtonSecondary**
- **Light Mode:** #F2F2F7 (RGB: 242, 242, 247)
- **Dark Mode:** #2C2C2E (RGB: 44, 44, 46)
- **Usage:** Secondary button background

#### **ButtonText**
- **Light Mode:** #FFFFFF (RGB: 255, 255, 255)
- **Dark Mode:** #FFFFFF (RGB: 255, 255, 255)
- **Usage:** Button text color

#### **Disabled**
- **Light Mode:** #C6C6C8 (RGB: 198, 198, 200) - 40% opacity
- **Dark Mode:** #48484A (RGB: 72, 72, 74) - 40% opacity
- **Usage:** Disabled state for buttons and inputs

---

### Gradient Colors

#### **FastingGradientStart**
- **Light Mode:** #007AFF (RGB: 0, 122, 255)
- **Dark Mode:** #0A84FF (RGB: 10, 132, 255)
- **Usage:** Fasting timer gradient start

#### **FastingGradientEnd**
- **Light Mode:** #5856D6 (RGB: 88, 86, 214)
- **Dark Mode:** #5E5CE6 (RGB: 94, 92, 230)
- **Usage:** Fasting timer gradient end

---

## 🎯 Quick Setup Checklist

- [ ] Open Xcode and navigate to Assets.xcassets
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
