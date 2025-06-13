// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SettingsDomain",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "SettingsDomain",
            targets: ["SettingsDomain"]),
    ],
    targets: [
        .target(
            name: "SettingsDomain"),
        .testTarget(
            name: "SettingsDomainTests",
            dependencies: ["SettingsDomain"]
        ),
    ]
)
