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
    case error
    
    var backgroundColor: Color {
        switch self {
        case .primary:
            return Color.Paynext.primaryButton
        case .secondary:
            return Color.Paynext.accentText
        case .tertiary:
            return Color.Paynext.primaryButton
        case .quartenary:
            return Color.Paynext.primaryText
        case .error:
            return Color.Paynext.secondaryText
        }
    }
    
    var textColor: Color {
        switch self {
        case .primary:
            return Color.Paynext.accentText
        case .secondary:
            return Color.Paynext.incomeText
        case .tertiary:
            return Color.Paynext.primaryText
        case .quartenary:
            return Color.Paynext.accentText
        case .error:
            return Color.Paynext.accentText
        }
    }
    
    var strokeColor: Color {
        switch self {
            
        case .primary:
            return Color.Paynext.primaryButton
        case .secondary:
            return Color.Paynext.incomeText
        case .tertiary:
            return Color.Paynext.primaryButton
        case .quartenary:
            return Color.Paynext.primaryText
        case .error:
            return Color.Paynext.secondaryText
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
            return CGFloat.medium
        case .error:
            return CGFloat.extraSmall
        }
    }
    
    var font: Font {
        switch self {
        case .primary:
            return .Paynext.body
        case .secondary:
            return .Paynext.body
        case .tertiary:
            return .Paynext.body
        case .quartenary:
            return .Paynext.footnote
        case .error:
            return .Paynext.body
        }
    }
}

public struct FilledButtonView: ViewModifier {
    
    let style: FilledButtonStyle
    var isButtonDisabled: Bool
    
    public func body(content: Content) -> some View {
        content
            .padding(.vertical, .medium)
            .frame(maxWidth: .infinity)
            .background(style.backgroundColor)
            .foregroundStyle(
                isButtonDisabled
                ? style.textColor.opacity(0.3)
                : style.textColor
            )
            .clippedRoundedCorners(style.radius)
            .font(style.font)
            .background(
                RoundedRectangle(cornerRadius: style.radius)
                    .stroke(
                        Color(style.strokeColor), lineWidth: 1
                    )
            )
    }
}

public extension View {
    func filledButton(_ style: FilledButtonStyle, isDisabled: Bool = false) -> some View {
        modifier(FilledButtonView(style: style, isButtonDisabled: isDisabled))
    }
}

#Preview {
    VStack(spacing: 16) {
        Button("Log in") {}
            .filledButton(.primary)
        
        Button("Save Preset") {}
            .filledButton(.secondary)
        
        Button("Save Preset") {}
            .filledButton(.tertiary)
        
        Button("Log Out") {}
            .filledButton(.quartenary)
        
        Button("Review payment details") {}
            .filledButton(.error)
    }
    .padding(.horizontal)
}
