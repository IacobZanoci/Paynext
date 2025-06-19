// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Transaction",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Transaction",
            targets: ["Transaction"]),
    ],
    targets: [
        .target(
            name: "Transaction",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "TransactionTests",
            dependencies: ["Transaction"]
        ),
    ]
)
