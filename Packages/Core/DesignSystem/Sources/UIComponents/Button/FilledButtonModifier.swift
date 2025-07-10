//
//  FilledButtonModifier.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import DesignSystem
import SwiftUI

public enum FilledButtonTone {
    case normal
    case destructive
}

public enum FilledButtonStyle {
    case primary
    case secondary
    case tertiary
    
    func backgroundColor(tone: FilledButtonTone) -> Color {
        switch (self, tone) {
        case (.primary, _):
            return Color.Paynext.accent
        case (.secondary, .normal):
            return Color.clear
        case (.secondary, .destructive):
            return Color.clear
        case (.tertiary, .normal):
            return Color.Paynext.contrast
        case (.tertiary, .destructive):
            return Color.Paynext.secondary
        }
    }
    
    func textColor(tone: FilledButtonTone) -> Color {
        switch (self, tone) {
        case (.primary, _):
            return Color.white
        case (.secondary, .normal):
            return Color.Paynext.positive
        case (.secondary, .destructive):
            return Color.Paynext.primary
        case (.tertiary, .normal):
            return Color.white
        case (.tertiary, .destructive):
            return Color.white
        }
    }
    
    func strokeColor(tone: FilledButtonTone) -> Color {
        switch (self, tone) {
        case (.primary, _):
            return Color.clear
        case (.secondary, .normal):
            return Color.Paynext.positive
        case (.secondary, .destructive):
            return Color.Paynext.primary
        case (.tertiary, .normal):
            return Color.clear
        case (.tertiary, .destructive):
            return Color.clear
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
        }
    }
}

public struct FilledButtonModifier: ViewModifier {
    
    @Environment(\.isEnabled) var isEnabled
    let style: FilledButtonStyle
    let tone: FilledButtonTone
    
    public func body(content: Content) -> some View {
        content
            .padding(.vertical, .medium)
            .frame(maxWidth: .infinity)
            .background(style.backgroundColor(tone: tone))
            .foregroundStyle(
                isEnabled
                ? style.textColor(tone: tone)
                : style.textColor(tone: tone).opacity(0.4)
            )
            .clippedRoundedCorners(.medium)
            .font(style.font)
            .background(
                RoundedRectangle(cornerRadius: .medium)
                    .stroke(Color(style.strokeColor(tone: tone)), lineWidth: 1)
            )
    }
}

public extension View {
    func filledButton(_ style: FilledButtonStyle, tone: FilledButtonTone = .normal) -> some View {
        modifier(FilledButtonModifier(style: style, tone: tone))
    }
    
    func primary() -> some View {
        filledButton(.primary, tone: .normal)
    }
    
    func secondary(tone: FilledButtonTone = .normal) -> some View {
        filledButton(.secondary, tone: tone)
    }
    
    func tertiary(tone: FilledButtonTone = .normal) -> some View {
        filledButton(.tertiary, tone: tone)
    }
}

#Preview {
    VStack(spacing: .medium) {
        Button("Primary") {}
            .filledButton(.primary)
        Button("Primary - Disabled") {}
            .filledButton(.primary)
            .disabled(true)
        
        Divider()
        
        Button("Secondary") {}
            .filledButton(.secondary, tone: .normal)
        
        Button("Secondary - Disabled") {}
            .filledButton(.secondary, tone: .normal)
            .disabled(true)
        
        Divider()
        
        Button("Secondary - Destructive") {}
            .filledButton(.secondary, tone: .destructive)
        
        Button("Secondary - Destructive - Disabled") {}
            .filledButton(.secondary, tone: .destructive)
            .disabled(true)
        
        Divider()
        
        Button("Tertiary") {}
            .filledButton(.tertiary, tone: .normal)
        
        Button("Tertiary - Disabled") {}
            .filledButton(.tertiary, tone: .normal)
            .disabled(true)
        
        Divider()
        
        Button("Tertiary - Destructive") {}
            .filledButton(.tertiary, tone: .destructive)
        
        Button("Tertiary - Destructive - Disabled") {}
            .filledButton(.tertiary, tone: .destructive)
            .disabled(true)
    }
    .padding(.horizontal)
}
