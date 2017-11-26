// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


extension Sequence {

  var descriptions: LazyMapSequence<Self, String> { return lazy.map { String(describing: $0) } }

  public func group<K>(_ fn: (Element) -> K?) -> [K:[Element]] {
    var d: [K:[Element]] = [:]
    for el in self {
      if let k = fn(el) {
        d.appendToValue(k, el)
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

  public func sortedMap<E: Comparable>(transform: (Element) throws -> E) rethrows -> [E] {
    var s = try map(transform)
    s.sort()
    return s
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

  public func reduce<Result>(first: (Element?) throws -> Result, _ nextPartialResult: (Result, Self.Element) throws -> Result) rethrows -> Result {
    var iter = makeIterator()
    let initialResult = try first(iter.next())
    return try IteratorSequence(iter).reduce(initialResult, nextPartialResult)
  }

  public func reduce<Result>(intoFirst: (Element?) throws -> Result, _ updateAccumulatingResult: (inout Result, Self.Element) throws -> ()) rethrows -> Result {
    var iter = makeIterator()
    let initialResult = try intoFirst(iter.next())
    return try IteratorSequence(iter).reduce(into: initialResult, updateAccumulatingResult)
  }
}
