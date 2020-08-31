// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics
import Quilt
import QuiltVec


extension CGSize {

  public init(_ w: Flt, _ h: Flt) { self.init(width: w, height: h) }

  // TODO: init<V: VecType2>(_ v: V) // requires that Scalar be FloatingPointTypeConvertible or something.

  public init(_ v: V2) { self.init(width: v.x, height: v.y) }

  public init(_ v: V2I) {
    self.init(width: Flt(v.x), height: Flt(v.y))
  }

  public var w: Flt {
    get { width }
    set { width = newValue }
  }

  public var h: Flt {
    get { height }
    set { height = newValue }
  }

  public var aspect: Flt { w / h }

  public var isPositive: Bool { w > 0 && h > 0 }
}

public func *(l: CGSize, r: Flt) -> CGSize { CGSize(l.w * r, l.h * r) }
public func /(l: CGSize, r: Flt) -> CGSize { CGSize(l.w / r, l.h / r) }

public func *(l: CGSize, r: CGSize) -> CGSize { CGSize(l.w * r.w, l.h * r.h) }
public func /(l: CGSize, r: CGSize) -> CGSize { CGSize(l.w / r.w, l.h / r.h) }
