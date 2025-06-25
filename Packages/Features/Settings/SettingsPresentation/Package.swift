// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SettingsPresentation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "SettingsPresentation",
            targets: ["SettingsPresentation"]),
    ],
    dependencies: [
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Persistance"),
        .package(path: "../../Features/LoginPresentation"),
        .package(path: "../SettingsDomain"),
        .package(path: "../../Core/BiometricsAuth")
    ],
    targets: [
        .target(
            name: "SettingsPresentation",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "UIComponents", package: "DesignSystem"),
                .product(name: "Persistance", package: "Persistance"),
                .product(name: "LoginPresentation", package: "LoginPresentation"),
                .product(name: "SettingsDomain", package: "SettingsDomain"),
                .product(name: "BiometricsAuth", package: "BiometricsAuth")
            ]
        ),
        .testTarget(
            name: "SettingsPresentationTests",
            dependencies: ["SettingsPresentation"]
        ),
    ]
)
