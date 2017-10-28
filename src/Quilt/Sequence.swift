// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


extension Sequence {

  public func group<K>(_ fn: (Element) -> K?) -> [K:[Element]] {
    var d: [K:[Element]] = [:]
    for e in self {
      if let k = fn(e) {
        d[k, default: []].append(e)
      }
    }
    return d
  }

  public func filterMap<E>(transform: (Element) throws -> E?) rethrows -> [E] {
    var a: [E] = []
    for e in self {
      if let t = try transform(e) {
        a.append(t)
      }
    }
    return a
  }

  public func mapToDict<K, V>(_ transform: (Element) -> (K, V)) -> [K:V] {
    var d: [K:V] = [:]
    for e in self {
      let (k, v) = transform(e)
      d[k] = v
    }
    return d
  }

  public func mapUniquesToDict<K, V>(_ transform: (Element) -> (K, V)) throws -> [K:V] {
    var d: [K:V] = [:]
    for e in self {
      let (k, v) = transform(e)
      if d.contains(key: k) { throw DuplicateKeyError(key: k, existing: d[k], incoming: v) }
      d[k] = v
    }
    return d
  }

  public func all(_ predicate: (Element) -> Bool) -> Bool {
    for e in self {
      if !predicate(e) {
        return false
      }
    }
    return true
  }

  public func any(_ predicate: (Element) -> Bool) -> Bool {
    for e in self {
      if predicate(e) {
        return true
      }
    }
    return false
  }
}


extension Sequence where Element: Equatable {

  public func replace(_ query: Element, with: Element) -> [Element] {
    var result: [Element] = []
    for e in self {
      if e == query {
        result.append(with)
      } else {
        result.append(e)
      }
    }
    return result
  }

  public func replace<Q: Collection, W: Collection>(_ query: Q, with: W) -> [Element]
    where Q.Element == Element, W.Element == Element {
    if query.isEmpty {
      return Array(self)
    }
    var buffer: [Element] = []
    var result: [Element] = []
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

  public func countOccurrencesOf(_ el: Element) -> Int {
    return reduce(0) { $1 == el ? $0 + 1 : $0 }
  }
}
