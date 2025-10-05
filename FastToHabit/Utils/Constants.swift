//
//  Constants.swift
//  FastToHabit
//
//  Created by Berta Matuliauskiene on 05/10/2025.
//

import SwiftUI

/// App-wide constants for consistent styling and configuration
/// [Rule: Code Organization - Constants]
enum Constants {
    
    // MARK: - Spacing
    
    enum Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    // MARK: - Corner Radius
    
    enum CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
    }
    
    // MARK: - Shadow
    
    enum Shadow {
        static let radius: CGFloat = 3
        static let opacity: CGFloat = 0.1
    }
    
    // MARK: - Animation
    
    enum Animation {
        /// Standard animation for most UI transitions (0.3s)
        static let standard: SwiftUI.Animation = .easeInOut(duration: 0.3)
        
        /// Quick animation for subtle changes (0.2s)
        static let quick: SwiftUI.Animation = .easeInOut(duration: 0.2)
        
        /// Slow animation for important transitions (0.5s)
        static let slow: SwiftUI.Animation = .easeInOut(duration: 0.5)
        
        /// Spring animation for bouncy effects
        static let spring: SwiftUI.Animation = .spring(response: 0.3, dampingFraction: 0.7)
        
        /// Duration values for custom animations
        static let durationQuick: Double = 0.2
        static let durationStandard: Double = 0.3
        static let durationSlow: Double = 0.5
    }
    
    // MARK: - Opacity
    
    enum Opacity {
        /// Disabled state opacity
        static let disabled: Double = 0.4
        
        /// Secondary content opacity
        static let secondary: Double = 0.6
        
        /// Hover/pressed state opacity
        static let pressed: Double = 0.8
        
        /// Overlay background opacity
        static let overlay: Double = 0.5
    }
    
    // MARK: - Icon Sizes
    
    enum IconSize {
        /// Small icons (16pt) - inline with text
        static let small: CGFloat = 16
        
        /// Medium icons (24pt) - buttons, list items
        static let medium: CGFloat = 24
        
        /// Large icons (32pt) - headers, feature icons
        static let large: CGFloat = 32
        
        /// Extra large icons (48pt) - empty states, onboarding
        static let extraLarge: CGFloat = 48
    }
    
    // MARK: - Button Dimensions
    
    enum Button {
        /// Standard button height
        static let height: CGFloat = 50
        
        /// Small button height
        static let heightSmall: CGFloat = 40
        
        /// Large button height
        static let heightLarge: CGFloat = 56
        
        /// Button horizontal padding
        static let horizontalPadding: CGFloat = 24
        
        /// Minimum button width
        static let minWidth: CGFloat = 120
    }
    
    // MARK: - Card Dimensions
    
    enum Card {
        /// Standard card padding
        static let padding: CGFloat = 16
        
        /// Card corner radius
        static let cornerRadius: CGFloat = 12
        
        /// Card shadow radius
        static let shadowRadius: CGFloat = 4
        
        /// Card shadow opacity
        static let shadowOpacity: Double = 0.1
        
        /// Card shadow offset
        static let shadowY: CGFloat = 2
    }
    
    // MARK: - Border
    
    enum Border {
        /// Thin border width
        static let thin: CGFloat = 1
        
        /// Medium border width
        static let medium: CGFloat = 2
        
        /// Thick border width
        static let thick: CGFloat = 3
    }
    
    // MARK: - Timer Display
    
    enum Timer {
        /// Timer circle size
        static let circleSize: CGFloat = 280
        
        /// Timer stroke width
        static let strokeWidth: CGFloat = 12
        
        /// Timer text size (handled by Typography)
        static let displaySize: CGFloat = 48
    }
    
    // MARK: - Layout
    
    enum Layout {
        /// Screen horizontal padding
        static let screenPadding: CGFloat = 20
        
        /// Maximum content width for larger screens
        static let maxContentWidth: CGFloat = 600
        
        /// List item height
        static let listItemHeight: CGFloat = 60
        
        /// Section spacing
        static let sectionSpacing: CGFloat = 32
    }
    
    // MARK: - App Info
    
    enum App {
        static let name = "Fast To Habit"
        static let version = "1.0.0"
        static let build = "1"
    }
}
