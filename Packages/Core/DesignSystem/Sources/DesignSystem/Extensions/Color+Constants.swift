//
//  Color+Constants.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import SwiftUI
import UIKit

public extension UIColor {
    
    /// The color scheme used in the Paynext app's TabBar.
    enum Paynext {
        
        // MARK: - TabBar
        
        /// The TabBar background color.
        public static let tabBarBackground = UIColor(named: "tabBarBackgroundColor", in: .module, compatibleWith: nil) ?? UIColor.systemBackground
        
        /// The `selected` TabBar item background color.
        public static let selectedTabBar = UIColor(named: "selectedTabBarColor", in: .module, compatibleWith: nil) ?? UIColor.systemGray2
        
        /// The `normal` TabBar item background color.
        public static let normalTabBar = UIColor(named: "normalTabBarColor", in: .module, compatibleWith: nil) ?? UIColor.secondaryLabel
    }
}

public extension Color {
    
    /// The color scheme used in the Paynext app.
    enum Paynext {
        
        // MARK: - Background
        
        /// The main background color of the application.
        public static let background = Color("backgroundColor", bundle: .module)
        
        /// The secondary background color of the application. Success or Failure Transaction Views.
        public static let secondaryBackground = Color("secondaryBackgroundColor", bundle: .module)
        
        /// The stroke background color of the application.
        public static let strokeBackground = Color("strokeBackgroundColor", bundle: .module)
        
        /// The error stroke background color of the application.
        public static let errorStrokeBackground = Color("errorStrokeBackgroundColor", bundle: .module)
        
        // MARK: - Button
        
        /// The primary button background color.
        public static let primaryButton = Color("primaryButtonColor", bundle: .module)
        
        /// The secondary button background color.
        public static let secondaryButton = Color("secondaryButtonColor", bundle: .module)
        
        /// The tertiary button background color.
        public static let tertiaryButton = Color("tertiaryButtonColor", bundle: .module)
        
        // MARK: - Text
        
        /// The color used for appName text elements.
        public static let appNameText = Color("appNameTextColor", bundle: .module)
        
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
