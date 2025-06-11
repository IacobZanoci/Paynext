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
        .package(path: "../TransactionHistoryDomain")
    ],
    targets: [
        .target(
            name: "TransactionHistoryPresentation",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "UIComponents", package: "DesignSystem"),
                .product(name: "TransactionHistoryDomain", package: "TransactionHistoryDomain")
            ]
        ),
        .testTarget(
            name: "TransactionHistoryPresentationTests",
            dependencies: ["TransactionHistoryPresentation"]
        ),
    ]
)
