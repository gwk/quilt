// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


extension Sequence {

  public func group<K>(_ fn: (Iterator.Element) -> K?) -> [K:[Iterator.Element]] {
    var d: [K:[Iterator.Element]] = [:]
    for e in self {
      if let k = fn(e) {
        d.appendToValue(k, e)
      }
    }
    return d
  }

  public func filterMap<E>(transform: (Iterator.Element) throws -> E?) rethrows -> [E] {
    var a: [E] = []
    for e in self {
      if let t = try transform(e) {
        a.append(t)
      }
    }
    return a
  }

  public func mapToDict<K, V>(_ transform: (Iterator.Element) -> (K, V)) -> [K:V] {
    var d: [K:V] = [:]
    for e in self {
      let (k, v) = transform(e)
      d[k] = v
    }
    return d
  }

  public func mapUniquesToDict<K, V>(_ transform: (Iterator.Element) -> (K, V)) throws -> [K:V] {
    var d: [K:V] = [:]
    for e in self {
      let (k, v) = transform(e)
      if d.contains(key: k) { throw DuplicateKeyError(key: k, existing: d[k], incoming: v) }
      d[k] = v
    }
    return d
  }

  public func all(_ predicate: (Iterator.Element) -> Bool) -> Bool {
    for e in self {
      if !predicate(e) {
        return false
      }
    }
    return true
  }

  public func any(_ predicate: (Iterator.Element) -> Bool) -> Bool {
    for e in self {
      if predicate(e) {
        return true
      }
    }
    return false
  }

  var first: Iterator.Element? {
    for first in self {
      return first
    }
    return nil
  }
}


extension Sequence where Iterator.Element: Equatable {

  public func replace(_ query: Iterator.Element, with: Iterator.Element) -> [Iterator.Element] {
    var result: [Iterator.Element] = []
    for e in self {
      if e == query {
        result.append(with)
      } else {
        result.append(e)
      }
    }
    return result
  }

  public func replace<Q: Collection, W: Collection>(_ query: Q, with: W) -> [Iterator.Element]
    where Q.Iterator.Element == Iterator.Element, W.Iterator.Element == Iterator.Element {
    if query.isEmpty {
      return Array(self)
    }
    var buffer: [Iterator.Element] = []
    var result: [Iterator.Element] = []
    var i = query.startIndex
    for e in self {
      if e == query[i] {
        i = query.index(after: i)
        if i == query.endIndex {
          result.append(contentsOf: with)
          buffer.removeAll()
          i = query.startIndex
        } else {
          buffer.append(e)
        }
      } else {
        result.append(contentsOf: buffer)
        result.append(e)
        buffer.removeAll()
        i = query.startIndex
      }
    }
    return result
  }

  public func countOccurrencesOf(_ el: Iterator.Element) -> Int {
    return reduce(0) { $1 == el ? $0 + 1 : $0 }
  }
}


extension Sequence where Iterator.Element == Bool {

  public func all() -> Bool {
    for e in self {
      if !e {
        return false
      }
    }
    return true
  }

  public func any() -> Bool {
    for e in self {
      if e {
        return true
      }
    }
    return false
  }
}


public func allZip<S1: Sequence, S2: Sequence>(_ seq1: S1, _ seq2: S2, predicate: (S1.Iterator.Element, S2.Iterator.Element) -> Bool) -> Bool {
  var g2 = seq2.makeIterator()
  for e1 in seq1 {
    guard let e2 = g2.next() else { return false }
    if !predicate(e1, e2) {
      return false
    }
  }
  return g2.next() == nil
}

