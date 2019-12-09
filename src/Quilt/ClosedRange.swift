// © 2019 George King. Permission to use this file is granted in license-quilt.txt.


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
