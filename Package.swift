// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
// Setup : https://youtu.be/DK6mSYEtTIk

import PackageDescription

let package = Package(
    name: "LuxCom",
    platforms: [.iOS(.v17), .macOS(.v14), .watchOS(.v10), .tvOS(.v17)],
    products: [
        .library(
            name: "LuxCom",
            targets: ["LuxCom"]),
    ],
    targets: [
        .target(
            name: "LuxCom",
            path: "Sources"
        )
    ]
)
