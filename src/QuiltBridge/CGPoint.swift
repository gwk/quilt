// © 2014 George King. Permission to use this file is granted in license-qk.txt.

import CoreGraphics


public typealias V2 = CGPoint

extension CGPoint {
  
  public init(_ x: CGFloat, _ y: CGFloat) { self.init(x: x, y: y) }

  public init(_ v: CGVector) { self.init(x: v.dx, y: v.dy) }
  
  public init(_ s: CGSize) { self.init(x: s.w, y: s.h) }

}

public func +(a: CGPoint, b: CGSize) -> CGPoint { return CGPoint(a.x + b.w, a.y + b.h) }
public func -(a: CGPoint, b: CGSize) -> CGPoint { return CGPoint(a.x - b.w, a.y - b.h) }
