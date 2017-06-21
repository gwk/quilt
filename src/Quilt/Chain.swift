// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


public enum Chain<Element>: IteratorProtocol, Sequence, ExpressibleByArrayLiteral, CustomStringConvertible {

  case end
  indirect case link(Element, Chain)

  public init<C: Collection>(_ collection: C) where C.Iterator.Element == Element {
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

  public var description: String {
    switch self {
    case .end: return "Chain()"
    case .link: return map({String(describing: $0)}).joined(separator:"=>")
    }
  }

  public func prepend(opt: Element?) -> Chain {
    if let hd = opt {
      return .link(hd, self)
    } else {
      return self
    }
  }

  public static func ==<Element>(l: Chain<Element>, r: Chain<Element>) -> Bool where Element: Equatable {
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
}
