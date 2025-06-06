// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PaymentPresentation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "PaymentPresentation",
            targets: ["PaymentPresentation"]
        ),
    ],
    dependencies: [
        .package(path: "../../Core/DesignSystem")
    ],
    targets: [
        .target(
            name: "PaymentPresentation",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "UIComponents", package: "DesignSystem")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "PaymentPresentationTests",
            dependencies: ["PaymentPresentation"]
        ),
    ]
)
