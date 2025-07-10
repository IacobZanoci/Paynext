//
//  SettingsButtonRowView.swift
//  DesignSystem
//
//  Created by Iacob Zanoci on 12.06.2025.
//

import SwiftUI

public struct SettingsButtonRowView: View {
    
    // MARK: - Properties
    
    let icon: String
    let title: String
    
    // MARK: - Initializers
    
    public init(
        icon: String,
        title: String
    ) {
        self.icon = icon
        self.title = title
    }
    
    // MARK: - View
    
    public var body: some View {
        HStack(spacing: .small) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundStyle(Color.Paynext.primary)
            
            Text(title)
                .font(.Paynext.body)
                .foregroundStyle(Color.Paynext.secondary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
                .foregroundStyle(Color.Paynext.primary)
        }
        .background(Color.clear)
    }
}

// MARK: - Preview

#Preview {
    SettingsButtonRowView(
        icon: "person.text.rectangle",
        title: "Personal Information"
    )
    .padding()
}
