// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension ClosedRange {

  public init(unordered a: Bound, _ b: Bound) {
    self = (a < b) ? a...b : b...a
  }
}


public func signedClosedRange<Bound: Comparable&Strideable>(_ a: Bound, _ b: Bound) -> AnyBidirectionalCollection<Bound>
  where Bound.Stride: SignedInteger {
  if a < b { return AnyBidirectionalCollection(a...b) }
  return AnyBidirectionalCollection((b...a).reversed())
}
