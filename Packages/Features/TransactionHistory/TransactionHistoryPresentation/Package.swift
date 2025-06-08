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
        .package(path: "../../Core/DesignSystem")
    ],
    targets: [
        .target(
            name: "TransactionHistoryPresentation",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "UIComponents", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "TransactionHistoryPresentationTests",
            dependencies: ["TransactionHistoryPresentation"]
        ),
    ]
)
