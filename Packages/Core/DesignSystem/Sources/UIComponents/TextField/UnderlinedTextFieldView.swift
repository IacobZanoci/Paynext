//
//  UnderlinedTextFieldView.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import DesignSystem
import SwiftUI

public struct UnderlinedTextFieldView: View {
    
    @Binding public var text: String
    public var placeholder: String
    
    public init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }
    
    public var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .font(.Paynext.body)
                .foregroundStyle(Color.Paynext.primaryText)
                .padding(.vertical, CGFloat.medium)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.Paynext.secondaryText.opacity(0.6))
                }
                .buttonStyle(.plain)
            }
        }
        .background(
            VStack {
                Spacer()
                Color(Color.Paynext.secondaryText.opacity(0.3))
                    .frame(height: 0.33)
            }
        )
    }
}

#Preview {
    UnderlinedTextFieldView(
        text: .constant(""),
        placeholder: "Name and Surname"
    )
}
