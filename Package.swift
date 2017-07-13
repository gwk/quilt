// swift-tools-version:4.0
// © 2016 George King. Permission to use this file is granted in license-quilt.txt.


import PackageDescription

let package = Package(
  name: "Quilt",
  products: [
    .library(name: "Quilt", targets: ["Quilt"])
  ],
  targets: [
    .target(name: "Quilt", path: "src/Quilt"),
    .target(name: "QuiltBridge", dependencies: ["Quilt"]),
    //.target(name: "QuiltMac", dependencies: ["Quilt", "QuiltBridge"]),
    //.target(name: "QuiltSpriteKit", dependencies: ["Quilt", "QuiltBridge"]),
  ],
  swiftLanguageVersions: [4]
)
