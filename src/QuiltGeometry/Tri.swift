// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Quilt


public struct Tri: CustomStringConvertible {
  public var a, b, c: Int

  public init(_ a: Int, _ b: Int, _ c: Int) {
    assert(a < b && a < c)
    self.a = a
    self.b = b
    self.c = c
  }

  public var description: String { return "Tri(\(a), \(b), \(c))" }

  public var swizzled: Tri { return Tri(a, c, b) }
}


