// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics


extension CGVector {

  public init(_ dx: CGFloat, _ dy: CGFloat) { self.init(dx: dx, dy: dy) }

  public init(_ v: V2) { self.init(dx: v.x, dy: v.y) }

  public var x: CGFloat {
    get { dx }
    set { dx = newValue }
  }

  public var y: CGFloat {
    get { dy }
    set { dy = newValue }
  }
}
