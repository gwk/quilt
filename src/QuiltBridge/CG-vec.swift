// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics
import Quilt


extension V2S {
  public init(_ p: CGPoint) { self.init(F32(p.x), F32(p.y)) }
  public init(_ s: CGSize) { self.init(F32(s.width), F32(s.height)) }
}
