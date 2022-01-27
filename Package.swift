// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let excludedFilenames: [String] = ["README.md"]

let package = Package(
    name: "LinearAlgebra",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "LinearAlgebra", targets: ["LinearAlgebra"]),
        .library(name: "Matrix", targets: ["Matrix"]),
        .library(name: "Vector", targets: ["Vector"]),
        
        
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        //MARK: - Public API
        .target(
            name: "LinearAlgebra",
            dependencies: ["Matrix", "Scalar", "Vector"],
            exclude: excludedFilenames),
        .target(
            name: "Matrix",
            dependencies: ["Scalar"],
            exclude: excludedFilenames),
        .target(
            name: "Scalar",
            dependencies: [],
            exclude: excludedFilenames),
        .target(
            name: "Vector",
            dependencies: ["Scalar"],
            exclude: excludedFilenames),
        
        // MARK: - Unit test bundles
        .testTarget(
            name: "MatrixTests",
            dependencies: ["Matrix"]),
        .testTarget(
            name: "VectorTests",
            dependencies: ["Vector"]),
    ]
)
