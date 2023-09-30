// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import CoreGraphics
import Quilt
import QuiltVec


extension CGSize {

  public init(_ w: Double, _ h: Double) { self.init(width: w, height: h) }

  // TODO: init<V: Vec2>(_ v: V) // requires that Scalar be FloatingPointTypeConvertible or something.

  public init(_ v: V2) { self.init(width: v.x, height: v.y) }

  public init(_ v: V2I) {
    self.init(width: Double(v.x), height: Double(v.y))
  }

  public var w: Double {
    get { width }
    set { width = newValue }
  }

  public var h: Double {
    get { height }
    set { height = newValue }
  }

  public var aspect: Double { w / h }

  public var isPositive: Bool { w > 0 && h > 0 }
}

public func *(l: CGSize, r: Double) -> CGSize { CGSize(l.w * r, l.h * r) }
public func /(l: CGSize, r: Double) -> CGSize { CGSize(l.w / r, l.h / r) }

public func *(l: CGSize, r: CGSize) -> CGSize { CGSize(l.w * r.w, l.h * r.h) }
public func /(l: CGSize, r: CGSize) -> CGSize { CGSize(l.w / r.w, l.h / r.h) }
