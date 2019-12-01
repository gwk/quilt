// swift-tools-version:5.1
// © 2016 George King. Permission to use this file is granted in license-quilt.txt.


import PackageDescription

let package = Package(
  name: "Quilt",
  platforms: [.macOS(.v10_15)],
  products: [
    .library(name: "Quilt",           targets: ["Quilt"]),
    .library(name: "QuiltGeometry",   targets: ["QuiltGeometry"]),
    .library(name: "QuiltMac",        targets: ["QuiltMac"]),
    .library(name: "QuiltSceneKit",   targets: ["QuiltSceneKit"]),
    .library(name: "QuiltSpriteKit",  targets: ["QuiltSpriteKit"]),
    .library(name: "QuiltUI",         targets: ["QuiltUI"]),
    .library(name: "UTest",           targets: ["UTest"]),

    .library(name: "QuiltTest", type: .dynamic, targets: ["QuiltTest"])
  ],
  targets: [
    .target(name: "Quilt"),
    .target(name: "QuiltGeometry",  dependencies: ["Quilt", "QuiltUI", "QuiltSceneKit"]),
    .target(name: "QuiltMac",       dependencies: ["Quilt", "QuiltUI"]),
    .target(name: "QuiltSceneKit",  dependencies: ["Quilt", "QuiltUI"]),
    .target(name: "QuiltSpriteKit", dependencies: ["Quilt", "QuiltUI"]),
    .target(name: "QuiltUI",        dependencies: ["Quilt"]),
    .target(name: "UTest", path: "src", sources: ["./UTest.swift"]),

    .target(name: "QuiltTest", dependencies: ["Quilt", "UTest"], path: "test/Quilt"),
  ],
  swiftLanguageVersions: [.v5]
)
