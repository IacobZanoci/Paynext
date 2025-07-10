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
    dependencies: [
        .package(path: "../NetworkClient")
    ],
    targets: [
        .target(
            name: "Transaction",
            dependencies: [
                .product(name: "NetworkClient", package: "NetworkClient")
            ],
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
