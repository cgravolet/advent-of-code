// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2022",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0")
    ],
    targets: [
        .executableTarget(
            name: "dec01",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .executableTarget(
            name: "dec02",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .executableTarget(
            name: "dec03",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .executableTarget(
            name: "dec04",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .executableTarget(
            name: "dec05",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .executableTarget(
            name: "dec06",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .testTarget(
            name: "swiftTests",
            dependencies: ["dec01"]),
    ]
)
