// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension Sequence where Element: Comparable {

  public var isSorted: Bool {
    var iter = makeIterator()
    guard var prev = iter.next() else { return true }
    while let el = iter.next() {
      if el < prev { return false }
      prev = el
    }
    return true
  }


  public var isSortedStrict: Bool {
    var iter = makeIterator()
    guard var prev = iter.next() else { return true }
    while let el = iter.next() {
      if el <= prev { return false }
      prev = el
    }
    return true
  }


  public func minmax() -> (Element, Element)? {
    var m: (Element, Element)? = nil
    for el in self {
      if let (mn, mx) = m {
        m = (Swift.min(mn, el), Swift.max(mx, el))
      } else {
        m = (el, el)
      }
    }
    return m
  }


 public func closedRange() -> ClosedRange<Element>? {
    return minmax().map { $0.0...$0.1 }
  }
}
