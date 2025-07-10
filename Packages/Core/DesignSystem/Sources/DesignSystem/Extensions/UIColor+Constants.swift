//
//  UIColor+Constants.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 10.07.2025.
//

import UIKit

public extension UIColor {
    
    /// The color scheme used in the Paynext app's TabBar.
    enum Paynext {
        
        // MARK: - TabBar
        
        /// The TabBar background color.
        public static let background = UIColor(named: "backgroundColor", in: .module, compatibleWith: nil) ?? UIColor.systemBackground
        
        /// The `active` TabBar item background color.
        public static let active = UIColor(named: "accentColor", in: .module, compatibleWith: nil) ?? UIColor.systemGray2
        
        /// The `inactive` TabBar item background color.
        public static let inactive = UIColor(named: "secondaryColor", in: .module, compatibleWith: nil) ?? UIColor.secondaryLabel
    }
}
