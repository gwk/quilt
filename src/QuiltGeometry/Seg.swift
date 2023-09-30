// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public struct Seg: CustomStringConvertible, Comparable, Hashable {
  public let a, b: Int // Not mutable to enforce ordering.

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

  public var description: String { "Seg(\(a), \(b))" }

  public func validate(vertexCount: Int) {
    precondition(a >= 0 && a < vertexCount)
    precondition(b >= 0 && b < vertexCount)
    precondition(a < b)
  }

  public static func <(l: Seg, r: Seg) -> Bool {
    if (l.a == r.a) {
      return l.b < r.b
    } else {
      return l.a < r.a
    }
  }
}
