//
//  Color+Constants.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import SwiftUI

public extension Color {
    
    /// The color scheme used in the Paynext app.
    enum Paynext {
        
        // MARK: - Background
        
        /// The main background color of the application.
        public static let background = Color("backgroundColor", bundle: .module)
        
        /// The secondary background color of the application. Success or Failure Transaction Views.
        public static let secondaryBackground = Color("secondaryBackgroundColor", bundle: .module)
        
        /// The color used to contrast the background color.
        public static let contrast = Color("contrastColor", bundle: .module)
        
        // MARK: - Button
        
        /// The primary button background color.
        public static let primaryButton = Color("primaryButtonColor", bundle: .module)
        
        /// The destructive button background color.
        public static let destructiveButton = Color("destructiveButtonColor", bundle: .module)
        
        /// The plain button foreground color.
        public static let plainButton = Color("plainButtonColor", bundle: .module)
        
        // MARK: - Text
        
        /// The color used for primary text elements.
        public static let primaryText = Color("primaryTextColor", bundle: .module)
        
        /// The color used for secondary text elements.
        public static let secondaryText = Color("secondaryTextColor", bundle: .module)
        
        /// The color used for tertiary text elements.
        public static let tertiaryText = Color("tertiaryTextColor", bundle: .module)
        
        /// The color used for accent text elements.
        public static let accentText = Color("accentTextColor", bundle: .module)
        
        /// The color used for contrast the background text elements.
        public static let contrastText = Color("contrastTextColor", bundle: .module)
        
        /// The color used for outcome state representation.
        public static let outcomeText = Color("outcomeTextColor", bundle: .module)
        
        /// The color used for income state representation.
        public static let incomeText = Color("incomeTextColor", bundle: .module)
    }
}
