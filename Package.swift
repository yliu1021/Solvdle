// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Solvdle",
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.1"),
  ],
  targets: [
    .executableTarget(
      name: "SolvdleCLI",
      dependencies: [
        "Solvdle",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]
    ),
    .target(
      name: "Solvdle",
      resources: [.process("Resources")]
    ),
    .testTarget(
      name: "SolvdleTests",
      dependencies: ["Solvdle"]
    ),
  ]
)
