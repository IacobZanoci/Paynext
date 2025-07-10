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
    
    public var title: String
    public var placeholder: String
    public var radius: CGFloat
    public var leftIcon: String?
    
    // MARK: - Initializers
    
    public init(
        text: Binding<String>,
        placeholder: String,
        isValid: Binding<Bool>,
        title: String,
        radius: CGFloat = .medium,
        leftIcon: String? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self._isValid = isValid
        self.title = title
        self.radius = radius
        self.leftIcon = leftIcon
    }
    
    // MARK: - View
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.Paynext.body)
                .foregroundStyle(Color.Paynext.primary)
            
            Spacer()
            if !isValid {
                Text("Wrong format")
                    .foregroundStyle(Color.Paynext.negative)
                    .font(.Paynext.caption)
                    .padding([.top, .trailing], .small)
            }
        }
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    if let leftIcon {
                        Image(systemName: leftIcon)
                            .font(.Paynext.body.weight(.medium))
                            .foregroundStyle(Color.Paynext.primary)
                            .padding(.leading, .medium)
                    }
                    
                    TextField(placeholder, text: $text)
                        .font(.Paynext.body)
                        .foregroundStyle(Color.Paynext.primary)
                        .padding(.medium)
                    
                    if !text.isEmpty {
                        Button(action: {
                            text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color.Paynext.tertiary)
                                .padding(.trailing, .medium)
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
                            ? Color.Paynext.tertiary
                            : Color.Paynext.negative,
                            lineWidth: 1.5
                        )
                )
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: .medium) {
        RoundedTextFieldView(
            text: .constant(""),
            placeholder: "Name and Surname",
            isValid: .constant(true),
            title: "Name"
        )
        
        RoundedTextFieldView(
            text: .constant(""),
            placeholder: "Name and Surname",
            isValid: .constant(false),
            title: "Name"
        )
        
        RoundedTextFieldView(
            text: .constant(""),
            placeholder: "0.00",
            isValid: .constant(true),
            title: "Amount",
            radius: .medium,
            leftIcon: "dollarsign"
        )
    }
    .padding()
}
