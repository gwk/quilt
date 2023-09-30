// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import QuiltVec


public struct ColCoordIterator: Sequence, IteratorProtocol {
  public typealias Element = V2I
  public typealias Iterator = ColCoordIterator

  private var start: V2I
  private var end: V2I
  private var step: V2I
  private var state: V2I

  public init(start: V2I, end: V2I, step: V2I) {
    self.start = start
    self.end = end
    self.step = step
    self.state = start
  }

  public mutating func next() -> Element? {
    if end.y <= 0 || state.x >= end.x { return nil }
    let c = state
    state.y += step.y
    if state.y >= end.y {
      state.y = start.y
      state.x += step.x
    }
    return c
  }
}
