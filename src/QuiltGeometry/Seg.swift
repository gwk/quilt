// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Quilt


public struct Seg: CustomStringConvertible, Comparable {
  public var a, b: Int

  public init(_ a: Int, _ b: Int) {
    assert(a != b)
    if (a < b) {
      self.a = a
      self.b = b
    } else {
      self.a = b
      self.b = a
    }
  }

  public var description: String { return "Seg(\(a), \(b))" }

  public static func <(l: Seg, r: Seg) -> Bool {
    if (l.a == r.a) {
      return l.b < r.b
    } else {
      return l.a < r.a
    }
  }
}
