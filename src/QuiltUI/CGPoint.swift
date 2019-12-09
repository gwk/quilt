// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics


extension CGPoint {

  public init(_ x: CGFloat, _ y: CGFloat) { self.init(x: x, y: y) }

  public init(_ v: CGVector) { self.init(x: v.dx, y: v.dy) }

  public init(_ s: CGSize) { self.init(x: s.w, y: s.h) }

  public subscript(index: Int) -> CGFloat {
    get {
      switch index {
      case 0: return x
      case 1: return y
      default: fatalError("CGPoint subscript out of range: \(index).")
      }
    }
    set {
      switch index {
      case 0: x = newValue
      case 1: y = newValue
      default: fatalError("CGPoint subscript out of range: \(index).")
      }
    }
  }

  public static func -(a: CGPoint, b: CGSize) -> CGPoint { return CGPoint(a.x - b.w, a.y - b.h) }
  public static func +(a: CGPoint, b: CGSize) -> CGPoint { return CGPoint(a.x + b.w, a.y + b.h) }
}
