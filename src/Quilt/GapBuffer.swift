// © 2017 George King. All rights reserved.

import Cocoa


public struct GapBuffer<Element> : Collection {

  public typealias Index = Int

  public struct Iterator : IteratorProtocol {
    var fwdIt: Array<Element>.Iterator
    var revIt: ReversedCollection<[Element]>.Iterator

    public init(_ gapBuffer: GapBuffer) {
      fwdIt = gapBuffer.fwd.makeIterator()
      revIt = gapBuffer.rev.reversed().makeIterator()
    }

    public mutating func next() -> Element? {
      return fwdIt.next() ?? revIt.next()
    }
  }

  private var fwd: [Element]
  private var rev: [Element]

  public init() {
    fwd = []
    rev = []
  }

  public init<S: Sequence>(_ seq: S) where S.Element == Element {
    fwd = Array(seq)
    rev = []
  }

  public var pos: Int {
    get { return fwd.count }
    set {
      while newValue < fwd.count { // advance.
        fwd.append(rev.removeLast())
      }
      while newValue > fwd.count { // rewind.
        rev.append(fwd.removeLast())
      }
    }
  }

  @inline(__always)
  private func revIdx(_ idx: Int) -> Int { return count - (idx + 1) }

  public func makeIterator() -> Iterator { return Iterator(self) }

  public var isEmpty: Bool { return count == 0 }

  public var count: Int { return fwd.count + rev.count }

  public var startIndex: Int { return 0 }

  public var endIndex: Int { return count }

  public var first: Element? { return fwd.first ?? rev.last }
  public var last: Element? { return rev.first ?? fwd.last }

  public subscript(idx: Int) -> Element {
    get {
      if idx < fwd.count { return fwd[idx] }
      else { return rev[revIdx(idx)] }
    }
    set {
      if idx < fwd.count { fwd[idx] = newValue }
      else { rev[revIdx(idx)] = newValue }
    }
  }

  public func index(after index: Index) -> Index { return index + 1 }

  public func index(where predicate: (Element) throws -> Bool) rethrows -> Index? {
    if let idx = try fwd.firstIndex(where: predicate) { return idx }
    if let idx = try rev.firstIndex(where: predicate) { return revIdx(idx) }
    return nil
  }

  public mutating func append(_ el: Element) {
    pos = count
    fwd.append(el)
  }

  mutating public func append<S: Sequence>(contentsOf s: S) where S.Element == Element {
    pos = count
    fwd.append(contentsOf: s)
  }

  mutating public func insert(_ el: Element, at: Int) {
    pos = at
    fwd.append(el)
  }
}


extension GapBuffer where Element: Equatable {

  public func firstIndex(of element: Element) -> Index? {
    if let idx = fwd.firstIndex(of: element) { return idx }
    if let idx = rev.lastIndex(of: element) { return revIdx(idx) }
    return nil
  }
}
