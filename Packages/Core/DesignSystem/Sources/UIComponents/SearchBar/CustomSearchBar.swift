//
//  CustomSearchBar.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 11.06.2025.
//

import SwiftUI

public struct CustomSearchBar: View {
    
    // MARK: - Properties
    
    @State private var searchText: String = ""
    let lineWidth: CGFloat = 1
    let contentPadding = EdgeInsets(
        top: 14,
        leading: 14,
        bottom: 14,
        trailing: 14
    )
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - View
    
    public var body: some View {
        HStack(spacing: .small) {
            Image(systemName: "target")
                .resizable()
                .scaledToFit()
                .frame(width: .medium, height: .medium)
                .foregroundStyle(Color.Paynext.primary)
            
            TextField("Search transactions", text: $searchText)
                .font(.Paynext.footnote)
                .foregroundStyle(Color.Paynext.secondary)
        }
        .padding(contentPadding)
        .background(
            RoundedRectangle(cornerRadius: .medium)
                .stroke(Color.Paynext.tertiary, lineWidth: lineWidth)
        )
        .background(Color.Paynext.background)
        .clippedRoundedCorners(.medium)
    }
}

// MARK: - Preview

#Preview {
    CustomSearchBar()
        .padding()
}
