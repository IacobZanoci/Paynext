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
            return Color.Paynext.primaryButton
        }
    }
    
    var textColor: Color {
        switch self {
        case .primary:
            return Color.Paynext.accentText
        case .secondary:
            return Color.Paynext.accentText
        case .destructive:
            return Color.Paynext.contrastText
        }
    }
    
    var font: Font {
        .Paynext.bodyMedium
    }
}

public struct FilledButtonView: ViewModifier {
    
    let style: FilledButtonStyle
    @Binding public var isButtonDisabled: Bool
    
    public func body(content: Content) -> some View {
        content
            .padding(.vertical, .medium)
            .frame(maxWidth: .infinity)
            .background(style.backgroundColor)
            .foregroundStyle(isButtonDisabled ? style.textColor.opacity(0.4) : style.textColor)
            .clippedRoundedCorners(16)
            .font(style.font)
    }
}

public extension View {
    func filledButton(_ style: FilledButtonStyle, isDisabled: Binding<Bool>) -> some View {
        modifier(FilledButtonView(style: style, isButtonDisabled: isDisabled))
    }
}

#Preview {
    VStack(spacing: 16) {
        Button("Log in") {}
            .filledButton(.primary, isDisabled: .constant(false))
        
        Button("Log in") {}
            .filledButton(.primary, isDisabled: .constant(true))
        
        Button("Save Preset") {}
            .filledButton(.secondary, isDisabled: .constant(false))
        
        Button("Log Out") {}
            .filledButton(.destructive, isDisabled: .constant(false))
    }
    .padding(.horizontal)
}
