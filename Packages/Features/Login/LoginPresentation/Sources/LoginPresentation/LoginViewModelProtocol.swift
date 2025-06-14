//
//  LoginViewModelProtocol.swift
//  LoginPresentation
//
//  Created by Iacob Zanoci on 31.05.2025.
//

import Foundation

@MainActor
public protocol LoginViewModelProtocol: ObservableObject {
    
    // MARK: - Properties
    
    var userName: String { get set }
    var accountNumber: String { get set }
    var routingNumber: String { get set }
    var usernameValidationState: Bool { get set }
    var accountNumberValidationState: Bool { get set }
    var routingNumberValidationState: Bool { get set }
    var isLoginDisabled: Bool { get set }
    
    // MARK: - Titles
    
    var appIconTitle: String { get }
    var loginFormTitle: String { get }
    var nameSurnameTitle: String { get }
    var accountNumberTitle: String { get }
    var routingNumberTitle: String { get }
    var loginButtonTitle: String { get }
    
    // MARK: - Placeholders
    
    var nameSurnamePlaceholder: String { get }
    var accountNumberPlaceholder: String { get }
    var routingNumberPlaceholder: String { get }
    
    // MARK: - Events
    
    func onLogin() async
}
