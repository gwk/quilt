// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


extension Array: DefaultInitializable {
  
  public var lastIndex: Int? { return count > 0 ? count - 1 : nil }
  
  public init(capacity: Int) {
    self = []
    self.reserveCapacity(capacity)
  }

  public init<S: Sequence where S.Iterator.Element == Iterator.Element>(join sequences: S...) {
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

  public mutating func permuteInPlace(_ random: Random) {
    if isEmpty { return }
    let c = count
    for i in 1..<c {
      let j = c - i
      let k = random.int(j + 1)
      if j == k { continue }
      swap(&self[j], &self[k])
    }
  }

  public func permute(_ random: Random) -> Array {
    var a = self
    a.permuteInPlace(random)
    return a
  }

  public func randomElement(_ random: Random) -> Element {
    return self[random.int(count)]
  }
}
