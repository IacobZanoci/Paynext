//
//  MainAppView.swift
//  Paynext
//
//  Created by Iacob Zanoci on 10.05.2025.
//

import SwiftUI

struct MainAppView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("PayNext")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text("This is the starting point.")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    MainAppView()
}
