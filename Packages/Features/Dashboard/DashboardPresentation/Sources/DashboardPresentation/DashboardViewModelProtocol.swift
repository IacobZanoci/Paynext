//
//  DashboardViewModelProtocol.swift
//  DashboardPresentation
//
//  Created by Iacob Zanoci on 14.06.2025.
//

import Foundation

@MainActor
public protocol DashboardViewModelProtocol: ObservableObject {
    
    // MARK: - Properties
    
    var username: String { get set }
    var actions: [ConfirmationAction] { get }
    var appDescriptionText: String { get }
    
    // MARK: - Methods
    
    func fetchUsername()
}
