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
        .package(path: "../../Core/Transaction"),
        .package(path: "../../Core/Persistance"),
        .package(path: "../../Core/NetworkClient"),
        .package(path: "../../Core/SettingsPresentation")
    ],
    targets: [
        .target(
            name: "TransactionHistoryPresentation",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "UIComponents", package: "DesignSystem"),
                .product(name: "Transaction", package: "Transaction"),
                .product(name: "Persistance", package: "Persistance"),
                .product(name: "NetworkClient", package: "NetworkClient"),
                .product(name: "SettingsPresentation", package: "SettingsPresentation")
            ]
        ),
        .testTarget(
            name: "TransactionHistoryPresentationTests",
            dependencies: ["TransactionHistoryPresentation"]
        ),
    ]
)
