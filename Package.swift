// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "JJFloatingActionButton",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "JJFloatingActionButton",
            targets: ["JJFloatingActionButton"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "JJFloatingActionButton",
            path: "Sources")
    ]
)
