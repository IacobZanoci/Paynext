// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "LoginPresentation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "LoginPresentation",
            targets: ["LoginPresentation"]
        ),
    ],
    dependencies: [
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Core/Persistance"),
        .package(path: "../LoginDomain"),
        .package(path: "../../CredentialsValidator")
    ],
    targets: [
        .target(
            name: "LoginPresentation",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "UIComponents", package: "DesignSystem"),
                .product(name: "Persistance", package: "Persistance"),
                .product(name: "LoginDomain", package: "LoginDomain"),
                .product(name: "CredentialsValidator", package: "CredentialsValidator")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "LoginPresentationTests",
            dependencies: [
                "LoginPresentation",
                "CredentialsValidator"
            ]
        ),
    ]
)
