//
//  AuthenticationViewModelProtocol.swift
//  AuthenticationPresentation
//
//  Created by Iacob Zanoci on 21.06.2025.
//

import Foundation
import SwiftUI

@MainActor
public protocol AuthenticationViewModelProtocol: ObservableObject {
    
    // MARK: - Dependencies
    
    var currentStep: AuthenticationEntryStep { get set }
    
    // MARK: - Properties
    
    var focusedIndex: Int? { get set }
    var showErrorAlert: Bool { get set }
    var pinNotMatchingError: Bool { get set }
    var pin: [String] { get set }
    var onPinSuccess: (() -> Void)? { get set }
    var onPin: (() -> Void)? { get set }
    var selectedOption: Int { get set }
    var pinLength: Int { get }
    
    // MARK: - Titles
    
    var clearButton: String { get }
    var cancelButton: String { get }
    var fourDigitOption: String { get }
    var sixDigitOption: String { get }
    var titleText: String { get }
    var buttons: [[String]] { get }
    var errorOrInfoText: String { get }
    var errorTextColor: Color { get }
    
    // MARK: - Actions
    
    func cancelFlow()
    func handleDigit(_ digit: String)
    func handleDelete()
    func resetState()
}
