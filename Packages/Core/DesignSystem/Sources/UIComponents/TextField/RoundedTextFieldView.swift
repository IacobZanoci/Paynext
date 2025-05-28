//
//  RoundedTextFieldView.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import DesignSystem
import SwiftUI

public struct RoundedTextFieldView: View {
    
    @Binding public var text: String
    public var placeholder: String
    public var isValid: Bool
    
    public init(
        text: Binding<String>,
        placeholder: String,
        isValid: Bool = true
    ) {
        self._text = text
        self.placeholder = placeholder
        self.isValid = isValid
    }
    
    public var body: some View {
        HStack {
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
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.Paynext.background)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    isValid
                    ? Color.Paynext.strokeBackground
                    : Color.Paynext.errorStrokeBackground,
                    lineWidth: 1.5
                )
        )
    }
}

#Preview {
    RoundedTextFieldView(
        text: .constant(""),
        placeholder: "Name and Surname"
    )
    .padding()
}
