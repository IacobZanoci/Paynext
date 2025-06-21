// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "DashboardPresentation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "DashboardPresentation",
            targets: ["DashboardPresentation"]),
    ],
    dependencies: [
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Persistance"),
        .package(path: "../LoginDomain"),
        .package(path: "../TransactionHistoryPresentation")
    ],
    targets: [
        .target(
            name: "DashboardPresentation",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "UIComponents", package: "DesignSystem"),
                .product(name: "Persistance", package: "Persistance"),
                .product(name: "LoginDomain", package: "LoginDomain"),
                .product(name: "TransactionHistoryPresentation", package: "TransactionHistoryPresentation")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "DashboardPresentationTests",
            dependencies: ["DashboardPresentation"]
        ),
    ]
)
