// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import QuiltVec


public struct AreaIndexIterator: Sequence, IteratorProtocol {

  public typealias Element = Int
  public typealias Iterator = AreaIndexIterator

  private var state: Int
  private var end: Int
  private var startRun: Int // Start of the current run (row or column).
  private var endRun: Int // End of current run (row or column).
  private var stepMajor: Int // Step to next run.
  private var stepMinor: Int // Step to next index.

  public init(start: Int, end: Int, endRun: Int, stepMajor: Int, stepMinor: Int) {
    self.state = start
    self.end = end
    self.startRun = start
    self.endRun = endRun
    self.stepMajor = stepMajor
    self.stepMinor = stepMinor
  }

  public mutating func next() -> Element? {
    if state >= end { return nil }
    let curr = state
    let n = state + stepMinor
    if n >= endRun {
      startRun += stepMajor
      endRun += stepMajor
      state = startRun
    } else {
      state = n
    }
    return curr
  }
}
