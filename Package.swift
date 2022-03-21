// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Solvdle",
  targets: [
    .executableTarget(
      name: "SolvdleCLI",
      dependencies: ["Solvdle"]
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
