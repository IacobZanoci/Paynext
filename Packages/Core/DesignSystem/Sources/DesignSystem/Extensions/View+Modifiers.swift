//
//  View+Modifiers.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import SwiftUI

public extension View {
    /// Applies a rounded corner style using a RoundedRectangle shape.
    /// Default radius is 6.0 points.
    func clippedRoundedCorners(_ radius: CGFloat = .small) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: radius))
    }
}
