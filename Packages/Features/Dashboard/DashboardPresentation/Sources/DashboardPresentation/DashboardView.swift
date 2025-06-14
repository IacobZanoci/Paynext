//
//  DashboardView.swift
//  DashboardPresentation
//
//  Created by Iacob Zanoci on 14.06.2025.
//

import SwiftUI

public struct DashboardView<ViewModel: DashboardViewModelProtocol>: View {
    
    // MARK: - Dependencies
    
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Initializers
    
    public init(
        viewModel: ViewModel
    ) {
        self.viewModel = viewModel
    }
    
    // MARK: - View
    
    public var body: some View {
        VStack {
            dashboard
        }
    }
}

// MARK: - View Extension

extension DashboardView {
    
    private var dashboard: some View {
        ScrollView {
            VStack(spacing: .small) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome back!")
                            .font(.Paynext.titleBold)
                            .foregroundStyle(Color.Paynext.accentText)
                            .padding(.vertical, .small)
                        Text(viewModel.username)
                            .font(.Paynext.navigationTitleMedium)
                            .foregroundStyle(Color.Paynext.accentText.opacity(0.9))
                            .onAppear {
                                viewModel.fetchUsername()
                            }
                    }
                    Spacer()
                }
                .padding(.large)
                Image("welcomeImage", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .foregroundStyle(Color.Paynext.accentText)
                    .padding(.bottom, .extraLarge)
            }
            .padding(.top, 40)
            .frame(maxWidth: .infinity)
            .background(Color.Paynext.secondaryBackground)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: .large) {
                    ForEach(viewModel.actions, id: \.self) { action in
                        circleButton(
                            icon: action.icon,
                            title: action.title,
                            titleFont: action.titleFont,
                            iconColor: action.iconColor,
                            backgroundColor: action.backgroundColor
                        )
                    }
                }
                .padding(.leading, .large)
                .padding(.vertical)
            }
            ZStack(alignment: .topTrailing) {
                HStack(spacing: .medium) {
                    VStack(alignment: .leading, spacing: .small) {
                        Text(viewModel.appDescriptionText)
                            .font(.Paynext.footnote)
                            .foregroundStyle(Color.Paynext.accentText)
                            .lineSpacing(.extraSmall)
                            .padding(.top, -.medium)
                    }
                    .multilineTextAlignment(.leading)
                    .layoutPriority(1)
                    
                    Image("dashboardCardImage", bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.Paynext.accentText)
                        .padding(.bottom, -60)
                }
                .padding()
                .frame(minHeight: 150)
                .background(Color.Paynext.tertiaryBackground)
                .cornerRadius(.large)
                
                Button(action: {}) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: .small, height: .small)
                        .foregroundStyle(Color.Paynext.accentText)
                        .padding(.medium)
                }
            }
            .padding(.horizontal, .large)
            Spacer()
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    func circleButton(
        icon: String,
        title: String,
        titleFont: Font,
        iconColor: Color,
        backgroundColor: Color
    ) -> some View {
        VStack(spacing: .small) {
            Button(action: {}) {
                ZStack {
                    Circle()
                        .fill(backgroundColor)
                        .frame(width:52, height: 52)
                    
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 26, height: 26)
                        .foregroundStyle(iconColor)
                }
            }
            Text(title)
                .font(titleFont)
                .foregroundStyle(Color.Paynext.primaryText)
        }
    }
}

// MARK: - Preview

#Preview {
    DashboardView(viewModel: MockDashboardViewModel())
}
