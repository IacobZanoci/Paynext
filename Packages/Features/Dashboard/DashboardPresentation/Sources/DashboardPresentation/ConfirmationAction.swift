//
//  ConfirmationAction.swift
//  DashboardPresentation
//
//  Created by Iacob Zanoci on 14.06.2025.
//

import SwiftUI
import DesignSystem

public enum ConfirmationAction: CaseIterable, Hashable {
    
    // MARK: - Enum Cases
    
    case transfer
    case scan
    case payBills
    case savings
    case request
    
    // MARK: - Icons
    
    var icon: String {
        switch self {
        case .transfer:
            return "creditcard"
        case .scan:
            return "qrcode"
        case .payBills:
            return "wallet.pass"
        case .savings:
            return "banknote"
        case .request:
            return "ellipsis.circle.fill"
        }
    }
    
    // MARK: - Titles
    
    var title: String {
        switch self {
        case .transfer:
            return "Transfer"
        case .scan:
            return "Scan"
        case .payBills:
            return "Pay Bills"
        case .savings:
            return "Savings"
        case .request:
            return "Request"
        }
    }
    
    var titleFont: Font {
        switch self {
        case .transfer:
            return .Paynext.body
        case .scan:
            return .Paynext.body
        case .payBills:
            return .Paynext.body
        case .savings:
            return .Paynext.body
        case .request:
            return .Paynext.body
        }
    }
    
    // MARK: - Icon Colour
    
    var iconColor: Color {
        switch self {
        case .transfer:
            return .white
        case .scan:
            return .white
        case .payBills:
            return .white
        case .savings:
            return .white
        case .request:
            return .white
        }
    }
    
    // MARK: - Icon Background Colour
    
    var backgroundColor: Color {
        switch self {
        case .transfer:
            return .Paynext.contrast
        case .scan:
            return .Paynext.contrast
        case .payBills:
            return .Paynext.contrast
        case .savings:
            return .Paynext.contrast
        case .request:
            return .Paynext.contrast
        }
    }
    
    // MARK: - Action Handler
    
    func handler(onTransferTap: @escaping () -> Void) -> () -> Void {
        switch self {
        case .transfer:
            return onTransferTap
        default:
            return {}
        }
    }
}
