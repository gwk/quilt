// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


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
