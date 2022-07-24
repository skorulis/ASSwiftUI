// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ASSwiftUI",
    platforms: [
        .macOS(.v11),
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ASSwiftUI",
            targets: ["ASSwiftUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/costachung/neumorphic/", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/siteline/SwiftUI-Introspect.git", .exact("0.1.3"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ASSwiftUI",
            dependencies: [
                .product(name: "Neumorphic", package: "neumorphic"),
                .product(name: "Introspect", package: "SwiftUI-Introspect")
            ],
            path: "Sources",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "ASSwiftUITests",
            dependencies: ["ASSwiftUI"]),
    ]
)
