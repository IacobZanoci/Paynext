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
        
        /// The main background color of the application.
        public static let background = Color("backgroundColor", bundle: .module)
        
        /// The contrast color of the main background.
        public static let contrast = Color("contrastColor", bundle: .module)
        
        /// The primary content color.
        public static let primary = Color("primaryColor", bundle: .module)
        
        /// The secondary content color.
        public static let secondary = Color("secondaryColor", bundle: .module)
        
        /// The tertiary content color.
        public static let tertiary = Color("tertiaryColor", bundle: .module)
        
        /// The accent color.
        public static let accent = Color("accentColor", bundle: .module)
        
        /// The color used to denote a positive state.
        public static let positive = Color("positiveColor", bundle: .module)
        
        /// The color used to denote a negative state.
        public static let negative = Color("negativeColor", bundle: .module)
    }
}
