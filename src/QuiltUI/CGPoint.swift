// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import CoreGraphics


extension CGPoint {

  public init(_ x: CGFloat, _ y: CGFloat) { self.init(x: x, y: y) }

  public init(_ v: CGVector) { self.init(x: v.dx, y: v.dy) }

  public init(_ s: CGSize) { self.init(x: s.w, y: s.h) }

  public static func -(a: CGPoint, b: CGSize) -> CGPoint { CGPoint(a.x - b.w, a.y - b.h) }
  public static func +(a: CGPoint, b: CGSize) -> CGPoint { CGPoint(a.x + b.w, a.y + b.h) }
}
