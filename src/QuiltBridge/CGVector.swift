// © 2015 George King. Permission to use this file is granted in license-qk.txt.

import CoreGraphics


extension CGVector {

  public init(_ dx: Flt, _ dy: Flt) { self.init(dx: dx, dy: dy) }

  public init(_ v: V2) { self.init(dx: v.x, dy: v.y) }

  public var x: Flt {
    get { return dx }
    set { dx = newValue }
  }

  public var y: Flt {
    get { return dy }
    set { dy = newValue }
  }
}
