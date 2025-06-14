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
        case .transfer: return "creditcard"
        case .scan: return "qrcode"
        case .payBills: return "wallet.pass"
        case .savings: return "banknote"
        case .request: return "ellipsis.circle.fill"
        }
    }
    
    // MARK: - Titles
    
    var title: String {
        switch self {
        case .transfer: return "Transfer"
        case .scan: return "Scan"
        case .payBills: return "Pay Bills"
        case .savings: return "Savings"
        case .request: return "Request"
        }
    }
    
    var titleFont: Font {
        switch self {
        case .transfer: return .Paynext.body
        case .scan: return .Paynext.body
        case .payBills: return .Paynext.body
        case .savings: return .Paynext.body
        case .request: return .Paynext.body
        }
    }
    
    // MARK: - Icon Colour
    
    var iconColor: Color {
        switch self {
        case .transfer: return .Paynext.accentText
        case .scan: return .Paynext.accentText
        case .payBills: return .Paynext.accentText
        case .savings: return .Paynext.accentText
        case .request: return .Paynext.accentText
        }
    }
    
    // MARK: - Icon Background Colour
    
    var backgroundColor: Color {
        switch self {
        case .transfer: return .Paynext.primaryText
        case .scan: return .Paynext.primaryText
        case .payBills: return .Paynext.primaryText
        case .savings: return .Paynext.primaryText
        case .request: return .Paynext.primaryText
        }
    }
}
