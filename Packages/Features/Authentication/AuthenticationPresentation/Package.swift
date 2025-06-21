// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AuthenticationPresentation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "AuthenticationPresentation",
            targets: ["AuthenticationPresentation"]),
    ],
    dependencies: [
        .package(path: "../../Core/Persistance"),
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../SettingsPresentation")
    ],
    targets: [
        .target(
            name: "AuthenticationPresentation",
            dependencies: [
                .product(name: "Persistance", package: "Persistance"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "SettingsPresentation", package: "SettingsPresentation")
            ]
        ),
        .testTarget(
            name: "AuthenticationPresentationTests",
            dependencies: ["AuthenticationPresentation"]
        ),
    ]
)
