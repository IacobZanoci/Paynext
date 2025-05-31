//
//  LoginViewModelProtocol.swift
//  LoginPresentation
//
//  Created by Iacob Zanoci on 31.05.2025.
//

import Foundation

public protocol LoginViewModelProtocol: ObservableObject {
    
    // MARK: - Properties
    
    var userName: String { get set }
    var accountNumber: String { get set }
    var routingNumber: String { get set }
    var usernameValidationState: Bool { get set }
    var accountNumberValidationState: Bool { get set }
    var routingNumberValidationState: Bool { get set }
    var isLoginDisabled: Bool { get set }
    
    // MARK: - Methods
    
    func onLogin()
}
