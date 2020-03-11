// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Alfred",
    platforms: [.macOS(.v10_13)],
    products: [
        .library(
            name: "Alfred",
            targets: ["Alfred"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Alfred",
            dependencies: []),
        .testTarget(
            name: "AlfredTests",
            dependencies: ["Alfred"]),
    ]
)
