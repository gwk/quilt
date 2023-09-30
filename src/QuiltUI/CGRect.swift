// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import CoreGraphics


extension CGRect {

  public static let unit = CGRect(0, 0, 1, 1)

  public init(x: Double, y: Double, w: Double, h: Double) { self.init(x: x, y: y, width: w, height: h) }

  public init(_ x: Double, _ y: Double, _ w: Double, _ h: Double) { self.init(x: x, y: y, width: w, height: h) }

  public init(_ w: Double, _ h: Double) { self.init(0, 0, w, h) }

  public init(_ o: CGPoint, _ s: CGSize) { self.init(o.x, o.y, s.w, s.h) }

  public init(c: CGPoint, s: CGSize) { self.init(c.x - s.w * 0.5, c.y - s.h * 0.5, s.w, s.h) }

  public init(_ s: CGSize) { self.init(0, 0, s.w, s.h) }


  public init(l: Double? = nil, r: Double? = nil, w: Double? = nil, t: Double? = nil, b: Double? = nil, h: Double? = nil) {
   self.init(
     x: l ?? (r! - w!),
     y: t ?? (b! - h!),
     width: w ?? (r! - l!),
     height: h ?? (b! - t!))
  }


  public init(p0: CGPoint, p1: CGPoint) {
    var x, y, w, h: Double
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
    get { origin }
    set { origin = newValue }
  }

  public var s: CGSize {
    get { size }
    set { size = newValue }
  }

  public var c: CGPoint {
    get { CGPoint(o.x + (0.5 * s.w), o.y + (0.5 * s.h)) }
    set { o = CGPoint(newValue.x - (0.5 * s.w), newValue.y - (0.5 * s.h)) }
  }

  public var x: Double {
    get { o.x }
    set { o.x = newValue }
  }

  public var y: Double {
    get { o.y }
    set { o.y = newValue }
  }

  public var w: Double {
    get { s.w }
    set { s.w = newValue }
  }

  public var h: Double {
    get { s.h }
    set { s.h = newValue }
  }

  public var l: Double {
    get { o.x }
    set { o.x = newValue }
  }

  public var t: Double {
    get { o.y }
    set { o.y = newValue }
  }

  public var r: Double {
    get { x + w }
    set { x = newValue - w }
  }

  public var b: Double {
    get { y + h }
    set { y = newValue - h }
  }

  public func insetBy(l: Double, t: Double, r: Double, b: Double) -> CGRect {
    CGRect(x: x + l, y: y + l, width: width - (l + r), height: height - (t + b))
  }

  public func insetBy(_ insets: CREdgeInsets) -> CGRect {
    insetBy(l: insets.l, t: insets.t, r: insets.r, b: insets.b)
  }

  public static let frameInit = CGRect(0, 0, 256, 256) // large, weird size to make it obvious when we forget to specify layout constraints.
}
