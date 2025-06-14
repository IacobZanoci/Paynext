//
//  DashboardViewModel.swift
//  DashboardPresentation
//
//  Created by Iacob Zanoci on 14.06.2025.
//

import Foundation
import LoginDomain
import Persistance

public class DashboardViewModel: DashboardViewModelProtocol {
    
    // MARK: - Properties
    
    @Published public var username: String = ""
    @Published public var actions: [ConfirmationAction] = ConfirmationAction.allCases
    @Published public var appDescriptionText: String = ("""
                                                        Paynext makes
                                                        sending money fast,
                                                        secure, and effortless - 
                                                        whether it's across the street
                                                        or across the world.
                                                        """)
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Methods
    
    public func fetchUsername() {
        if let user: LoginDomain.PaynextUser = UserDefaultsManager.shared.get(forKey: .paynextUser) {
            username = user.userName
        }
    }
}
