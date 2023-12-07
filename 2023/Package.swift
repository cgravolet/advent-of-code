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

// Enable Regex literal syntax
for target in package.targets {
    target.swiftSettings = target.swiftSettings ?? []

    // Swift 5.7
    // target.swiftSettings?.append(.unsafeFlags([
    //     "-Xfrontend", "-warn-concurrency",
    //     "-Xfrontend", "-enable-actor-data-race-checks",
    //     "-enable-bare-slash-regex",
    // ]))

    // Swift 5.8+
    target.swiftSettings?.append(contentsOf: [
        .enableUpcomingFeature("BareSlashRegexLiterals"),
        .enableUpcomingFeature("StrictConcurrency"),
        .unsafeFlags(["-enable-actor-data-race-checks"], .when(configuration: .debug)),
    ])
}
