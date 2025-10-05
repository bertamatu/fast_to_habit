#!/bin/bash

# Script to create color assets for Fast To Habit
# This creates all 24 color sets in Assets.xcassets

ASSETS_DIR="FastToHabit/Assets.xcassets"

# Function to create a color set
create_color() {
    local name=$1
    local light_r=$2
    local light_g=$3
    local light_b=$4
    local dark_r=$5
    local dark_g=$6
    local dark_b=$7
    
    local dir="$ASSETS_DIR/${name}.colorset"
    mkdir -p "$dir"
    
    cat > "$dir/Contents.json" << EOF
{
  "colors" : [
    {
      "color" : {
        "color-space" : "srgb",
        "components" : {
          "alpha" : "1.000",
          "blue" : "$(echo "scale=3; $light_b/255" | bc)",
          "green" : "$(echo "scale=3; $light_g/255" | bc)",
          "red" : "$(echo "scale=3; $light_r/255" | bc)"
        }
      },
      "idiom" : "universal"
    },
    {
      "appearances" : [
        {
          "appearance" : "luminosity",
          "value" : "dark"
        }
      ],
      "color" : {
        "color-space" : "srgb",
        "components" : {
          "alpha" : "1.000",
          "blue" : "$(echo "scale=3; $dark_b/255" | bc)",
          "green" : "$(echo "scale=3; $dark_g/255" | bc)",
          "red" : "$(echo "scale=3; $dark_r/255" | bc)"
        }
      },
      "idiom" : "universal"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF
    
    echo "✅ Created $name"
}

echo "🎨 Creating color assets for Fast To Habit..."
echo ""

# Brand Colors
echo "Creating Brand Colors..."
create_color "BrandPrimary" 10 126 164 100 210 255
create_color "BrandSecondary" 139 92 246 167 139 250
create_color "BrandAccent" 16 185 129 52 211 153

# Semantic Colors
echo "Creating Semantic Colors..."
create_color "FastingActive" 10 126 164 100 210 255
create_color "FastingComplete" 5 150 105 16 185 129
create_color "SupplementReminder" 139 92 246 167 139 250
create_color "SupplementComplete" 5 150 105 16 185 129

# Status Colors
echo "Creating Status Colors..."
create_color "Success" 5 150 105 16 185 129
create_color "Warning" 245 158 11 251 191 36
create_color "Error" 239 68 68 248 113 113
create_color "Info" 10 126 164 100 210 255

# UI Colors
echo "Creating UI Colors..."
create_color "BackgroundPrimary" 249 250 251 17 24 39
create_color "BackgroundSecondary" 255 255 255 31 41 55
create_color "BackgroundTertiary" 243 244 246 55 65 81
create_color "CardBackground" 255 255 255 31 41 55
create_color "TextTertiary" 156 163 175 107 114 128
create_color "Divider" 229 231 235 55 65 81
create_color "Border" 209 213 219 75 85 99

# Interactive Colors
echo "Creating Interactive Colors..."
create_color "ButtonPrimary" 10 126 164 100 210 255
create_color "ButtonSecondary" 0 0 0 0 0 0  # Transparent (will be handled differently)
create_color "ButtonText" 255 255 255 255 255 255
create_color "Disabled" 156 163 175 107 114 128

# Gradient Colors
echo "Creating Gradient Colors..."
create_color "FastingGradientStart" 10 126 164 100 210 255
create_color "FastingGradientEnd" 16 185 129 52 211 153

echo ""
echo "✅ All 24 color sets created!"
echo ""
echo "Next steps:"
echo "1. Open Xcode and check Assets.xcassets"
echo "2. Build the project (⌘+B)"
echo "3. Run to see your colors!"
