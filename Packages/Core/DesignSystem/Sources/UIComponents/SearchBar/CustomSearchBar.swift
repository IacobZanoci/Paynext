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
    let cornerRadius: CGFloat = 6
    let lineWidth: CGFloat = 1
    let contentPadding = EdgeInsets(
        top: 12,
        leading: 12,
        bottom: 12,
        trailing: 12
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
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.Paynext.tertiary, lineWidth: lineWidth)
        )
        .background(Color.Paynext.background)
        .clippedRoundedCorners(cornerRadius)
    }
}

// MARK: - Preview

#Preview {
    CustomSearchBar()
        .padding()
}
