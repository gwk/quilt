// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Quilt


public struct Seg<I: FixedWidthInteger>: CustomStringConvertible, Comparable where I: IntegerInitable {
  public var a, b: I

  public init(_ a: I, _ b: I) {
    assert(a != b)
    if (a < b) {
      self.a = a
      self.b = b
    } else {
      self.a = b
      self.b = a
    }
  }

  public init(_ seg: Seg<Int>) {
    self.init(I(seg.a), I(seg.b))
  }

  public var description: String { return "Seg(\(a), \(b))" }

  public static func ==<I>(l: Seg<I>, r: Seg<I>) -> Bool {
    return l.a == r.a && l.b == r.b
  }

  public static func <<I>(l: Seg<I>, r: Seg<I>) -> Bool {
    if (l.a == r.a) {
      return l.b < r.b
    } else {
      return l.a < r.a
    }
  }
}
