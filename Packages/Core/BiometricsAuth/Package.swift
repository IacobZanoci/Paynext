// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "BiometricsAuth",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "BiometricsAuth",
            targets: ["BiometricsAuth"]),
    ],
    dependencies: [
        .package(path: "../Persistance")
    ],
    targets: [
        .target(
            name: "BiometricsAuth",
            dependencies: [
                .product(name: "Persistance", package: "Persistance")
            ]
        ),
        .testTarget(
            name: "BiometricsAuthTests",
            dependencies: ["BiometricsAuth"]
        ),
    ]
)
