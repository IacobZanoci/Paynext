// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "LoginDomain",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "LoginDomain",
            targets: ["LoginDomain"]),
    ],
    targets: [
        .target(
            name: "LoginDomain"),
        .testTarget(
            name: "LoginDomainTests",
            dependencies: ["LoginDomain"]
        ),
    ]
)
