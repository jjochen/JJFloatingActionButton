// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "JJFloatingActionButton",
    products: [
        .library(
            name: "JJFloatingActionButton",
            targets: ["JJFloatingActionButton"]),
    ],
    targets: [
        .target(
            name: "JJFloatingActionButton",
            path: "Sources")
    ]
)
