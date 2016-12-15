// © 2014 George King. Permission to use this file is granted in license-qk.txt.

import CoreGraphics


extension CGRect {

  public static let unit = CGRect(0, 0, 1, 1)

  public init(_ x: Flt, _ y: Flt, _ w: Flt, _ h: Flt) { self.init(x: x, y: y, width: w, height: h) }

  public init(x: Flt, y: Flt, r: Flt, b: Flt) { self.init(x, y, r - x, b - y) }

  public init(_ w: Flt, _ h: Flt) { self.init(0, 0, w, h) }

  public init(_ o: CGPoint, _ s: CGSize) { self.init(o.x, o.y, s.w, s.h) }

  public init(c: CGPoint, s: CGSize) { self.init(c.x - s.w * 0.5, c.y - s.h * 0.5, s.w, s.h) }

  public init(_ s: CGSize) { self.init(0, 0, s.w, s.h) }

  public init(p0: CGPoint, p1: CGPoint) {
    var x, y, w, h: Flt
    if p0.x < p1.x {
      x = p0.x
      w = p1.x - p0.x
    } else {
      x = p1.x
      w = p0.x - p1.x
    }
    if p0.y < p1.y {
      y = p0.y
      h = p1.y - p0.y
    } else {
      y = p1.y
      h = p0.y - p1.y
    }
    self.init(x, y, w, h)
  }

  public var o: CGPoint {
    get { return origin }
    set { origin = newValue }
  }

  public var s: CGSize {
    get { return size }
    set { size = newValue }
  }

  public var c: CGPoint {
    get { return CGPoint(o.x + (0.5 * s.w), o.y + (0.5 * s.h)) }
    set { o = CGPoint(newValue.x - (0.5 * s.w), newValue.y - (0.5 * s.h)) }
  }

  public var x: Flt {
    get { return o.x }
    set { o.x = newValue }
  }

  public var y: Flt {
    get { return o.y }
    set { o.y = newValue }
  }

  public var w: Flt {
    get { return s.w }
    set { s.w = newValue }
  }

  public var h: Flt {
    get { return s.h }
    set { s.h = newValue }
  }

  public var r: Flt {
    get { return x + w }
    set { x = newValue - w }
  }

  public var b: Flt {
    get { return y + h }
    set { y = newValue - h }
  }
}

public let frameInit = CGRect(0, 0, 256, 256) // large, weird size to make it obvious when we forget to specify layout constraints.
