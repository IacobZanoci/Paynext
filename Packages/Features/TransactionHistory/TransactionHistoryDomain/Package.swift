// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "TransactionHistoryDomain",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "TransactionHistoryDomain",
            targets: ["TransactionHistoryDomain"]),
    ],
    targets: [
        .target(
            name: "TransactionHistoryDomain",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "TransactionHistoryDomainTests",
            dependencies: ["TransactionHistoryDomain"]
        ),
    ]
)
