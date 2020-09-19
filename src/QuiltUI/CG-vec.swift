// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics
import Quilt
import QuiltVec


extension V2F {
  public init(_ p: CGPoint) { self.init(Float(p.x), Float(p.y)) }
  public init(_ s: CGSize) { self.init(Float(s.width), Float(s.height)) }
}
