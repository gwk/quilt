// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


extension Collection {

  public var range: Range<Index> { return startIndex..<endIndex }

  public func part(_ range: Range<Index>) -> (SubSequence, SubSequence) {
    let ra = startIndex..<range.lowerBound
    let rb = range.upperBound..<endIndex
    return (self[ra], self[rb])
  }
}


extension Collection where Iterator.Element : Equatable {

  public func contains(_ element: Iterator.Element) -> Bool {
    return index(of: element) != nil
  }

  public func contains<S: Sequence>(sequence: S, atIndex: Index) -> Bool where S.Element == Element {
    return indexAfter(sequence: sequence, atIndex: atIndex) != nil
  }

  public func indexAfter<S: Sequence>(sequence: S, atIndex: Index) -> Index? where S.Element == Element {
    var i = atIndex
    for e in sequence {
      if i == endIndex || e != self[i] {
        return nil
      }
      i = index(after: i)
    }
    return i
  }

  public func indexAfter<S: Sequence>(prefix: S) -> Index? where S.Element == Element {
    return indexAfter(sequence: prefix, atIndex: startIndex)
  }

  public func part(_ separator: Self, start: Index? = nil, end: Index? = nil) -> (SubSequence, SubSequence)? {
    if let range = rangeOf(separator, start: start, end: end) {
      return part(range)
    }
    return nil
  }

  public func rangeOf<C: Collection>(_ query: C, start: Index? = nil, end: Index? = nil) -> Range<Index>?
   where C.Element == Element {
    var i = start ?? startIndex
    let e = end ?? endIndex
    while i != e {
      var j = i
      var found = true
      for el in query {
        if j == e {
          return nil // ran out of domain.
        }
        if el != self[j] {
          found = false
          break
        }
        j = index(after: j)
      }
      if found { // all characters matched.
        return i..<j
      }
      i = index(after: i)
    }
    return nil
  }

  public func split<C: Collection>(sub: C, maxSplit: Int = Int.max, allowEmptySlices: Bool = false) -> [Self.SubSequence]
   where C.Element == Element {
    var result: [Self.SubSequence] = []
    var prev = startIndex
    var range = rangeOf(sub)
    while let r = range {
      if allowEmptySlices || prev != r.lowerBound {
        result.append(self[prev..<r.lowerBound])
      }
      prev = r.upperBound
      range = rangeOf(sub, start: prev)
      if result.count == maxSplit {
        break
      }
    }
    if allowEmptySlices || prev != endIndex {
      result.append(self[prev..<endIndex])
    }
    return result
  }
}


extension Collection where Element: Comparable {

  public var isSorted: Bool {
    var prev: Element? = nil
    for el in self {
      if let prev = prev {
        if !(prev < el) {
          return false
        }
      }
      prev = el
    }
    return true
  }
}


public func zipExact<C0: Collection, C1: Collection>(_ c0: C0, _ c1: C1) -> Zip2Sequence<C0, C1>
 where C0.IndexDistance == C1.IndexDistance {
  precondition(c0.count == c1.count)
  return zip(c0, c1)
}
