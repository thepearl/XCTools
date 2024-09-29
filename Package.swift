// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "XCTools",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "XCTools",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Rainbow",
            ]),
        .testTarget(
            name: "XCToolsTests",
            dependencies: ["XCTools"]),
    ]
)
