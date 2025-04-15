// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ICD10Kit",
    platforms: [
        .macOS(.v14),
        .iOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ICD10Kit",
            targets: ["ICD10Kit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: "10.11.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ICD10Kit",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift")
            ]
        ),
        .testTarget(
            name: "ICD10KitTests",
            dependencies: ["ICD10Kit"]
        ),
    ]
)
