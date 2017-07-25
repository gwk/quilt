// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Quilt


public struct Tri<I: FixedWidthInteger>: CustomStringConvertible where I: IntegerInitable {
  public var a, b, c: I

  public init(_ a: I, _ b: I, _ c: I) {
    assert(a < b && a < c)
    self.a = a
    self.b = b
    self.c = c
  }

  public init(_ tri: Tri<Int>) {
    self.init(I(tri.a), I(tri.b), I(tri.c))
  }

  public var description: String { return "Tri(\(a), \(b), \(c))" }

  public var swizzled: Tri<I> { return Tri(a, c, b) }
}


