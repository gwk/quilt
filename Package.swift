// swift-tools-version:5.7
// © 2016 George King. Permission to use this file is granted in license-quilt.txt.


import PackageDescription

let package = Package(
  name: "Quilt",
  platforms: [.macOS(.v13)],
  products: [
    .library(name: "Py",              targets: ["Py"]),
    .library(name: "Quilt",           targets: ["Quilt"]),
    .library(name: "QuiltArea",       targets: ["QuiltArea"]),
    .library(name: "QuiltArithmetic", targets: ["QuiltArithmetic"]),
    .library(name: "QuiltCoding",     targets: ["QuiltCoding"]),
    .library(name: "QuiltDispatch",   targets: ["QuiltDispatch"]),
    .library(name: "QuiltGeometry",   targets: ["QuiltGeometry"]),
    .library(name: "QuiltMac",        targets: ["QuiltMac"]),
    .library(name: "QuiltNoise",      targets: ["QuiltNoise"]),
    .library(name: "QuiltRandom",     targets: ["QuiltRandom"]),
    .library(name: "QuiltResource",   targets: ["QuiltResource"]),
    .library(name: "QuiltSceneKit",   targets: ["QuiltSceneKit"]),
    .library(name: "QuiltSpriteKit",  targets: ["QuiltSpriteKit"]),
    .library(name: "QuiltThreads",    targets: ["QuiltThreads"]),
    .library(name: "QuiltUI",         targets: ["QuiltUI"]),
    .library(name: "QuiltVec",        targets: ["QuiltVec"]),
    .library(name: "UTest",           targets: ["UTest"]),
    .library(name: "QuiltTest", type: .dynamic, targets: ["QuiltTest"])
  ],
  targets: [
    .target(name: "Py"
      //swiftSettings: [.unsafeFlags(["-enable-library-evolution"])]
    ),
    .target(name: "Quilt"),
    .target(name: "QuiltArea",      dependencies: ["QuiltVec"]),
    .target(name: "QuiltArithmetic"),
    .target(name: "QuiltCoding"),
    .target(name: "QuiltDispatch"),
    .target(name: "QuiltGeometry",  dependencies: ["Quilt", "QuiltArea", "QuiltVec"]),
    .target(name: "QuiltMac",       dependencies: ["Quilt", "QuiltUI"]),
    .target(name: "QuiltNoise",     dependencies: ["QuiltArithmetic"]),
    .target(name: "QuiltRandom",    dependencies: ["Quilt"]),
    .target(name: "QuiltResource",  dependencies: ["Quilt", "QuiltDispatch"]),
    .target(name: "QuiltSceneKit",  dependencies: ["Quilt", "QuiltGeometry", "QuiltUI"]),
    .target(name: "QuiltSpriteKit", dependencies: ["Quilt", "QuiltUI"]),
    .target(name: "QuiltThreads"),
    .target(name: "QuiltUI",        dependencies: ["Quilt", "QuiltArea", "QuiltRandom", "QuiltVec"]),
    .target(name: "QuiltVec",       dependencies: ["QuiltArithmetic"]),
    .target(name: "UTest"),

    .target(name: "QuiltTest",
      dependencies: ["Quilt", "QuiltArea", "QuiltArithmetic", "QuiltCoding", "UTest"],
      path: "test/Quilt"),
  ],
  swiftLanguageVersions: [.v5]
)
