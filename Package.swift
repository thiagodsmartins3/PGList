// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PGList",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PGList",
            targets: ["PGList"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.4"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PGList",
            dependencies: ["Alamofire"]),
        .testTarget(
            name: "PGListTests",
            dependencies: ["PGList"]),
    ]
)
