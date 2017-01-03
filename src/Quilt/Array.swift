// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


extension Array: DefaultInitializable {

  public var lastIndex: Int? { return count > 0 ? count - 1 : nil }

  public init(capacity: Int) {
    self = []
    self.reserveCapacity(capacity)
  }

  public init<S: Sequence>(join sequences: S...) where S.Iterator.Element == Iterator.Element {
    self = []
    for s in sequences {
      append(contentsOf: s)
    }
  }

  public func optEl(_ index: Int) -> Element? {
    if index >= 0 && index < count {
      return self[index]
    } else {
      return nil
    }
  }

  public mutating func put(_ index: Int, el: Element, dflt: Element) {
    if index < count {
      self[index] = el
    } else {
      reserveCapacity(index + 1)
      while count < index {
        append(dflt)
      }
      append(el)
    }
  }

  public mutating func removeBySwappingLast(_ index: Int) -> Element {
    let last = self.removeLast()
    if index != count {
      let val = self[index]
      self[index] = last
      return val
    } else {
      return last
    }
  }
}
