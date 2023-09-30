// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
