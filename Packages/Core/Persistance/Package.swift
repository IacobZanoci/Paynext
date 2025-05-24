// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Persistance",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Persistance",
            targets: ["Persistance"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Persistance",
            dependencies: [],
            resources: [
                .process("Model.xcdatamodeld")
            ],
            linkerSettings: [
                .linkedFramework("CoreData")
            ]
        ),
        .testTarget(
            name: "PersistanceTests",
            dependencies: ["Persistance"]
        ),
    ]
)
