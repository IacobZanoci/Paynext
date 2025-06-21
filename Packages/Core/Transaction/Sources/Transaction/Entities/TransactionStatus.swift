//
//  TransactionStatus.swift
//  Transaction
//
//  Created by Iacob Zanoci on 19.06.2025.
//

import Foundation

public enum TransactionStatus: String, CaseIterable, Codable, Equatable {
    
    case completed = "COMPLETED"
    case progress = "PROGRESS"
    case failed = "FAILED"
    case rejected = "REJECTED"
    
    public var status: String {
        switch self {
        case .completed:
            return "Completed"
        case .progress:
            return "In progress"
        case .failed:
            return "Failed"
        case .rejected:
            return "Rejected"
        }
    }
}
