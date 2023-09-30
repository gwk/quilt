// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import QuiltVec


public struct RowCoordIterator: Sequence, IteratorProtocol {
  public typealias Element = V2I
  public typealias Iterator = RowCoordIterator

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
    if end.x <= 0 || state.y >= end.y { return nil }
    let c = state
    state.x += step.x
    if state.x >= end.x {
      state.x = start.x
      state.y += step.y
    }
    return c
  }
}
