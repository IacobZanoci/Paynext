// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "TransactionHistoryPresentation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "TransactionHistoryPresentation",
            targets: ["TransactionHistoryPresentation"]),
    ],
    dependencies: [
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Transaction")
    ],
    targets: [
        .target(
            name: "TransactionHistoryPresentation",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "UIComponents", package: "DesignSystem"),
                .product(name: "Transaction", package: "Transaction")
            ]
        ),
        .testTarget(
            name: "TransactionHistoryPresentationTests",
            dependencies: ["TransactionHistoryPresentation"]
        ),
    ]
)
