// © 2014 George King. Permission to use this file is granted in license-qk.txt.

import CoreGraphics
import Quilt


extension CGSize {

  public init(_ w: Flt, _ h: Flt) { self.init(width: w, height: h) }

  // TODO: init<V: VecType2>(_ v: V) // requires that Scalar be FloatingPointTypeConvertible or something.

  public init(_ v: V2) { self.init(width: v.x, height: v.y) }

  public init(_ v: V2I) {
    self.init(width: Flt(v.x), height: Flt(v.y))
  }

  public var w: Flt {
    get { return width }
    set { width = newValue }
  }

  public var h: Flt {
    get { return height }
    set { height = newValue }
  }

  public var aspect: Flt { return w / h }

  public var isPositive: Bool { return w > 0 && h > 0 }
}

public func *(l: CGSize, r: Flt) -> CGSize { return CGSize(l.w * r, l.h * r) }
public func /(l: CGSize, r: Flt) -> CGSize { return CGSize(l.w / r, l.h / r) }

public func *(l: CGSize, r: CGSize) -> CGSize { return CGSize(l.w * r.w, l.h * r.h) }
public func /(l: CGSize, r: CGSize) -> CGSize { return CGSize(l.w / r.w, l.h / r.h) }
