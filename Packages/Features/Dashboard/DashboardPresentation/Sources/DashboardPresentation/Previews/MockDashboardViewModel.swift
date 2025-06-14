//
//  MockDashboardViewModel.swift
//  DashboardPresentation
//
//  Created by Iacob Zanoci on 14.06.2025.
//

import Foundation

final class MockDashboardViewModel: DashboardViewModelProtocol, ObservableObject {
    
    @Published var username: String = "Iacob"
    @Published var actions: [ConfirmationAction] = ConfirmationAction.allCases
    @Published var appDescriptionText: String = ("""
                                                    Paynext makes
                                                    sending money fast,
                                                    secure, and effortless - 
                                                    whether it's across the street
                                                    or across the world.
                                                    """)
    
    func fetchUsername() { }
}
