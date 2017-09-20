// swift-tools-version:4.0
// © 2016 George King. Permission to use this file is granted in license-quilt.txt.


import PackageDescription

let package = Package(
  name: "Quilt",
  products: [
    .library(name: "Quilt", targets: ["Quilt"])
  ],
  targets: [
    .target(name: "Quilt"),
    .target(name: "QuiltUI",        dependencies: ["Quilt"]),
    .target(name: "QuiltMac",       dependencies: ["Quilt", "QuiltUI"]),
    .target(name: "QuiltSceneKit",  dependencies: ["Quilt", "QuiltUI"]),
    .target(name: "QuiltSpriteKit", dependencies: ["Quilt", "QuiltUI"]),
    .target(name: "QuiltGeometry",  dependencies: ["Quilt", "QuiltUI", "QuiltSceneKit"]),
    .target(name: "QTest", path: "src", sources: ["./QTest.swift"]),

    .testTarget(name: "Test", dependencies: ["QTest", "Quilt"], path: "test/Quilt"),
  ],
  swiftLanguageVersions: [4]
)
