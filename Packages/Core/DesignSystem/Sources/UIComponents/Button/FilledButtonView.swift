//
//  FilledButtonView.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import DesignSystem
import SwiftUI

public enum FilledButtonStyle {
    case primary
    case secondary
    case destructive
    
    var backgroundColor: Color {
        switch self {
        case .primary:
            return Color.Paynext.primaryButton
        case .secondary:
            return Color.Paynext.primaryButton.opacity(0.15)
        case .destructive:
            return Color.Paynext.destructiveButton
        }
    }
    
    var textColor: Color {
        switch self {
        case .primary:
            return Color.Paynext.contrastText
        case .secondary:
            return Color.Paynext.accentText
        case .destructive:
            return Color.Paynext.contrastText
        }
    }
    
    var font: Font {
        .Paynext.footnote
    }
}

public struct FilledButtonView: ViewModifier {
    
    let style: FilledButtonStyle
    
    public func body(content: Content) -> some View {
        content
            .frame(height: 36)
            .padding(.vertical, .extraSmall)
            .frame(maxWidth: .infinity)
            .background(style.backgroundColor)
            .foregroundStyle(style.textColor)
            .clippedRoundedCorners(40)
            .font(style.font)
    }
}

public extension View {
    func filledButton(_ style: FilledButtonStyle) -> some View {
        modifier(FilledButtonView(style: style))
    }
}

#Preview {
    VStack(spacing: 16) {
        Button("Log in") {}
            .filledButton(.primary)
        
        Button("Save Preset") {}
            .filledButton(.secondary)
        
        Button("Log Out") {}
            .filledButton(.destructive)
    }
    .padding(.horizontal)
}
