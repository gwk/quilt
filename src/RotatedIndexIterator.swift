// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


public struct RotatedIndexIterator: Sequence, IteratorProtocol {
  public typealias Element = Int
  public let count: Int
  public let start: Int
  public var step: Int

  public init(count: Int, start: Int) {
    self.count = count
    self.start = start
    self.step = 0
  }

  public mutating func next() -> Element? {
    if step == count {
      return nil
    }
    let i = step
    step += 1
    return (i + start) % count
  }
}




