// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public struct CaseArray<Enum: DenseEnum, Element>: Collection, ExpressibleByArrayLiteral {

  public typealias Index = Enum?
  public typealias ArrayLiteralElement = Element


  public struct Iterator : IteratorProtocol {
    private var it: Array<Element>.Iterator

    public init(_ array: CaseArray) {
      it = array.storage.makeIterator()
    }

    public mutating func next() -> Element? { it.next() }
  }


  private var storage: [Element]


  public init() {
    storage = []
  }


  public init<S: Sequence>(_ seq: S) where S.Element == Element {
    storage = Array(seq)
  }

  public init(arrayLiteral elements: Element...) {
    self.init(elements)
  }

  public init(pairs: (Enum, Element)...) {
    self.init()
    for (k, el) in pairs {
      self[k] = el // TODO: this looks out-of-bounds.
    }
  }


  public func makeIterator() -> Iterator { Iterator(self) }

  public var isEmpty: Bool { count == 0 }

  public var count: Int { storage.count }

  public var startIndex: Index { Enum(rawValue: 0) }

  public var endIndex: Index { storage.count < Enum.count ? Enum(rawValue: storage.count) : nil }

  public var first: Element? { storage.first }
  public var last: Element? { storage.last }


  public subscript(index: Index) -> Element {
    get {
      guard let index = index else { fatalError("Index is nil") }
      return storage[index.rawValue]
    }
    set {
      guard let index = index else { fatalError("Index is nil") }
      if index.rawValue == storage.count {
        storage.append(newValue)
      } else {
        storage[index.rawValue] = newValue
      }
    }
  }


  public func index(after index: Index) -> Index {
    guard let index = index else { return nil }
    let nextIndex = index.rawValue + 1
    if nextIndex >= Enum.count { return nil }
    return Enum(rawValue: nextIndex)
  }


  public func index(where predicate: (Element) throws -> Bool) rethrows -> Index? {
    if let i = try storage.firstIndex(where: predicate) {
      return Enum(rawValue: i)
    }
    return nil
  }


  public mutating func append(_ el: Element) {
    if count >= Enum.count { fatalError("CaseArray is full; cannot append.") }
    storage.append(el)
  }
}
