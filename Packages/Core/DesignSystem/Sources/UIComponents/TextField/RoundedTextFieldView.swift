//
//  RoundedTextFieldView.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import DesignSystem
import SwiftUI

public struct RoundedTextFieldView: View {
    
    // MARK: - Properties
    
    @Binding public var text: String
    @Binding public var isValid: Bool
    
    public var placeholder: String
    public var radius: CGFloat
    public var leftIcon: String?
    
    // MARK: - Initializers
    
    public init(
        text: Binding<String>,
        placeholder: String,
        isValid: Binding<Bool>,
        radius: CGFloat = 16,
        leftIcon: String? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self._isValid = isValid
        self.radius = radius
        self.leftIcon = leftIcon
    }
    
    // MARK: - View
    
    public var body: some View {
        HStack(spacing: 0) {
            if let leftIcon {
                Image(systemName: leftIcon)
                    .font(.Paynext.bodyMedium)
                    .foregroundStyle(Color.Paynext.primaryText)
                    .padding(.leading, 12)
            }
            
            TextField(placeholder, text: $text)
                .font(.Paynext.body)
                .foregroundStyle(Color.Paynext.primaryText)
                .padding(.medium)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.Paynext.secondaryText.opacity(0.6))
                        .padding(.trailing, 16)
                }
                .buttonStyle(.plain)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: radius)
                .fill(Color.Paynext.background)
        )
        .overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(
                    isValid
                    ? Color.Paynext.strokeBackground
                    : Color.Paynext.errorStrokeBackground,
                    lineWidth: 1.5
                )
        )
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        RoundedTextFieldView(
            text: .constant(""),
            placeholder: "Name and Surname",
            isValid: .constant(true)
        )
        
        RoundedTextFieldView(
            text: .constant(""),
            placeholder: "Name and Surname",
            isValid: .constant(false)
        )
        
        RoundedTextFieldView(
            text: .constant(""),
            placeholder: "0.00",
            isValid: .constant(true),
            radius: 6,
            leftIcon: "dollarsign"
        )
    }
    .padding()
}
