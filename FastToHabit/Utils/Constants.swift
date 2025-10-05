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
        static let standard: SwiftUI.Animation = .easeInOut(duration: 0.3)
        static let quick: SwiftUI.Animation = .easeInOut(duration: 0.2)
    }
    
    // MARK: - App Info
    
    enum App {
        static let name = "Fast To Habit"
        static let version = "1.0.0"
        static let build = "1"
    }
}
