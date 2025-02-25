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
    dependencies: [
        .package(url: "https://github.com/openTdataCH/ojp-ios.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "LuxCom",
            dependencies: [
                .product(name: "OJP", package: "ojp-ios")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "LuxComTests",
            dependencies: ["LuxCom"]
        ),
    ]
)
