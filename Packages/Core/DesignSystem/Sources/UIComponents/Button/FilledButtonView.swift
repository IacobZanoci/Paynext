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
    case tertiary
    case quartenary
    
    var backgroundColor: Color {
        switch self {
        case .primary:
            return Color.Paynext.primaryButton
        case .secondary:
            return Color.Paynext.primaryButton.opacity(0.5)
        case .tertiary:
            return Color.Paynext.primaryButton
        case .quartenary:
            return Color.Paynext.primaryButton
        }
    }
    
    var textColor: Color {
        switch self {
        case .primary:
            return Color.Paynext.accentText
        case .secondary:
            return Color.Paynext.accentText
        case .tertiary:
            return Color.Paynext.primaryText
        case .quartenary:
            return Color.Paynext.contrastText
        }
    }
    
    var radius: CGFloat {
        switch self {
        case .primary:
            return CGFloat.medium
        case .secondary:
            return CGFloat.medium
        case .tertiary:
            return CGFloat.medium
        case .quartenary:
            return CGFloat.extraSmall
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
            .foregroundStyle(style.textColor)
            .clippedRoundedCorners(style.radius)
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
        
        Button("Save Preset") {}
            .filledButton(.secondary, isDisabled: .constant(false))
        
        Button("Save Preset") {}
            .filledButton(.tertiary, isDisabled: .constant(false))
        
        Button("Log Out") {}
            .filledButton(.quartenary, isDisabled: .constant(false))
    }
    .padding(.horizontal)
}
