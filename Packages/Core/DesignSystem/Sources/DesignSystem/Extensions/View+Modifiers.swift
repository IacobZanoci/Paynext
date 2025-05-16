//
//  View+Modifiers.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import SwiftUI

public extension View {
    /// Applies a rounded corner style using a RoundedRectangle shape.
    /// Default radius is 8.0 points.
    func clippedRoundedCorners(_ radius: CGFloat = 8.0) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: radius))
    }
}
