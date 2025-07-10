//
//  Font+Constants.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import SwiftUI

public extension Font {
    
    ///The font styles used in the Paynext app.
    enum Paynext {
        
        // MARK: - Caption
        
        /// Font used for caption elements.
        ///
        /// Equivalent to the system font with a `12.0` size.
        public static let caption = Font.system(size: 12.0)
        
        // MARK: - Footnote
        
        /// Font used for footnote elements.
        ///
        /// Equivalent to the system font with a `14.0` size.
        public static let footnote = Font.system(size: 14.0)
        
        // MARK: - Body
        
        /// Font used for body elements.
        ///
        /// Equivalent to the system font with a `16.0` size.
        public static let body = Font.system(size: 16.0)
        
        // MARK: - Navigation Title
        
        /// Font used for navigationTitle.
        ///
        /// Equivalent to the system font with a `18.0` size.
        public static let navigationTitle = Font.system(size: 18.0)
        
        // MARK: - Subheadline
        
        /// Font used for subheadline elements.
        ///
        /// Equivalent to the system font with a `20.0` size.
        public static let subheadline = Font.system(size: 20.0)
        
        // MARK: - Headline
        
        /// Font used for headline elements.
        ///
        /// Equivalent to the system font with a `24.0` size.
        public static let headline = Font.system(size: 24.0)
        
        // MARK: - Title
        
        /// Font used for title elements.
        ///
        /// Equivalent to the system font with a `32.0` size.
        public static let title = Font.system(size: 32.0)
    }
}
