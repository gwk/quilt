// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


public struct Adj: CustomStringConvertible, Comparable {
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

  public var description: String { return "Adj(\(a), \(b))" }

  public static func <(l: Adj, r: Adj) -> Bool {
    if (l.a == r.a) {
      return l.b < r.b
    } else {
      return l.a < r.a
    }
  }
}
