// swift-tools-version: 5.9
import PackageDescription

let dependencies: [Target.Dependency] = [
    .product(name: "Algorithms", package: "swift-algorithms"),
    .product(name: "ArgumentParser", package: "swift-argument-parser"),
    .product(name: "Collections", package: "swift-collections"),
]

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-format.git", .upToNextMajor(from: "509.0.0"))
    ],
    targets: [
        .executableTarget(
            name: "AdventOfCode",
            dependencies: dependencies
        ),
        .testTarget(
            name: "AdventOfCodeTests",
            dependencies: ["AdventOfCode"] + dependencies
        ),
    ]
)
