// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


extension Collection where Iterator.Element : Equatable {

  public var range: Range<Index> { return startIndex..<endIndex }

  public func contains(_ element: Iterator.Element) -> Bool {
    return index(of: element) != nil
  }

  public func contains<S: Sequence where S.Iterator.Element == Iterator.Element>(sequence: S, atIndex: Index) -> Bool {
    return indexAfter(sequence: sequence, atIndex: atIndex) != nil
  }

  public func indexAfter<S: Sequence where S.Iterator.Element == Iterator.Element>(sequence: S, atIndex: Index) -> Index? {
    var i = atIndex
    for e in sequence {
      if i == endIndex || e != self[i] {
        return nil
      }
      i = index(after: i)
    }
    return i
  }

  public func part(_ range: Range<Index>) -> (SubSequence, SubSequence) {
    let ra = startIndex..<range.lowerBound
    let rb = range.upperBound..<endIndex
    return (self[ra], self[rb])
  }

  public func part(_ separator: Self, start: Index? = nil, end: Index? = nil) -> (SubSequence, SubSequence)? {
    if let range = rangeOf(separator, start: start, end: end) {
      return part(range)
    }
    return nil
  }

  public func rangeOf<C: Collection where C.Iterator.Element == Iterator.Element>(_ query: C, start: Index? = nil, end: Index? = nil) -> Range<Index>? {
    var i = start.or(startIndex)
    let e = end.or(endIndex)
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
  
  public func split<C: Collection where C.Iterator.Element == Iterator.Element>(sub: C, maxSplit: Int = Int.max, allowEmptySlices: Bool = false) -> [Self.SubSequence] {
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


extension Collection where Iterator.Element: Comparable {

  public var isSorted: Bool {
    var prev: Iterator.Element? = nil
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


public func zipExact<C0: Collection, C1: Collection where C0.IndexDistance == C1.IndexDistance>(_ c0: C0, _ c1: C1) ->
  Zip2Sequence<C0, C1> {
  assert(c0.count == c1.count)
  return zip(c0, c1)
}
