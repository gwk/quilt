// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


public enum Chain<Element>: IteratorProtocol, Sequence, ArrayLiteralConvertible {

  case end
  indirect case link(Element, Chain)
  
  init<C: Collection where C.Iterator.Element == Element, C.Index: Comparable>(_ collection: C) {
    var c: Chain<Element> = .end
    for e in collection.reversed() {
      c = .link(e, c)
    }
    self = c
  }

  public init(arrayLiteral elements: Element...) {
    self.init(elements)
  }

  public func makeIterator() -> Chain {
    return self
  }

  public mutating func next() -> Element? {
    switch self {
    case .end: return nil
    case .link(let hd, let tl):
      self = tl
      return hd
    }
  }

  public var isEmpty: Bool {
    switch self {
    case .end: return true
    case .link: return false
    }
  }
}


public func ==<Element where Element: Equatable>(l: Chain<Element>, r: Chain<Element>) -> Bool {
  var l = l
  var r = r
  while true {
    switch l {
    case .end: return r.isEmpty
    case .link(let lh, let lt):
      switch r {
      case .end: return false
      case .link(let rh, let rt):
        if lh != rh {
          return false
        }
        l = lt
        r = rt
      }
    }
  }
}
