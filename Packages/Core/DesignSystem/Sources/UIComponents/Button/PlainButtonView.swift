//
//  PlainButtonView.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 16.05.2025.
//

import DesignSystem
import SwiftUI

struct PlainButtonView: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(.Paynext.body)
            .foregroundStyle(Color.Paynext.plainButton)
    }
}

public extension View {
    func plainButton() -> some View {
        modifier(PlainButtonView())
    }
}

#Preview {
    Button("Filter") {}
        .plainButton()
}
