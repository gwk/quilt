// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


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
}
