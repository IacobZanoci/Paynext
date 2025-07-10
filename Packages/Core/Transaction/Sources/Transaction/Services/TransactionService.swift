//
//  TransactionService.swift
//  Transaction
//
//  Created by Iacob Zanoci on 19.06.2025.
//

import Foundation
import NetworkClient

public final class TransactionService: TransactionServiceProtocol {
    
    // MARK: - Dependencies
    
    private let networkClient: NetworkClientProtocol
    private let config: TransactionAPIConfig
    
    // MARK: - Initializers
    
    public init(
        networkClient: NetworkClientProtocol = NetworkClient(),
        config: TransactionAPIConfig = StaticTransactionAPIConfig()
    ) {
        self.networkClient = networkClient
        self.config = config
    }
    
    // MARK: - Fetching Transactions
    
    public func fetchAllTransactions(page: Int?, pageSize: Int?) async throws -> [TransactionItem] {
        let url = config.baseURL.appendingPathComponent("/apiservice/transactions")
        let headers = ["Authorization": "Bearer \(config.token)"]
        var queryItems: [URLQueryItem] = []
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        if let pageSize = pageSize {
            queryItems.append(URLQueryItem(name: "pageSize", value: "\(pageSize)"))
        }
        
        let data = try await networkClient.get(
            from: url,
            headers: headers,
            queryItems: queryItems
        )
        
        struct RemoteResponse: Decodable {
            let transactions: [TransactionItem]
        }
        
        do {
            let decoded = try JSONDecoder().decode(RemoteResponse.self, from: data)
            return decoded.transactions
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
