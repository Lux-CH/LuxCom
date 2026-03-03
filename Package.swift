// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
// Setup : https://youtu.be/DK6mSYEtTIk

import PackageDescription

let package = Package(
    name: "LuxCom",
    platforms: [.iOS(.v16), .macOS(.v14), .watchOS(.v9), .tvOS(.v16)],
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
