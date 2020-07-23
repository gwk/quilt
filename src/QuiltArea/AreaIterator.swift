// © 2015 George King. Permission to use this file is granted in license.txt.

import QuiltVec


public struct AreaIterator: Sequence, IteratorProtocol {
  public typealias Element = V2I
  public typealias Iterator = AreaIterator

  private var start: V2I
  private var end: V2I
  private var step: V2I
  private var coord: V2I

  public init(start: V2I, end: V2I, step: V2I) {
    self.start = start
    self.end = end
    self.step = step
    self.coord = start
  }

  public mutating func next() -> Element? {
    if end.x <= 0 || coord.y >= end.y { return nil }
    let c = coord
    coord.x += step.x
    if coord.x >= end.x {
      coord.x = start.x
      coord.y += step.y
    }
    return c
  }
}



