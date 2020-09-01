// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics


extension CGPoint {

  public init(_ x: CGFloat, _ y: CGFloat) { self.init(x: x, y: y) }

  public init(_ v: CGVector) { self.init(x: v.dx, y: v.dy) }

  public init(_ s: CGSize) { self.init(x: s.w, y: s.h) }

  public static func -(a: CGPoint, b: CGSize) -> CGPoint { CGPoint(a.x - b.w, a.y - b.h) }
  public static func +(a: CGPoint, b: CGSize) -> CGPoint { CGPoint(a.x + b.w, a.y + b.h) }
}
