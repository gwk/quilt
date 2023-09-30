// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import CoreGraphics
import Quilt
import QuiltVec


extension V2F {
  public init(_ p: CGPoint) { self.init(Float(p.x), Float(p.y)) }
  public init(_ s: CGSize) { self.init(Float(s.width), Float(s.height)) }
}
