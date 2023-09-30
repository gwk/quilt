// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation
import Quilt


public struct Random: RandomNumberGenerator {
  // XorShift128Plus generator.

  private var state0: UInt64
  private var state1: UInt64

  public init(state0: UInt64 = 0x123456789ABCDEF, state1: UInt64 = 0x123456789ABCDEF) {
    self.state0 = state0
    self.state1 = state1
  }

  public init(seeded: Bool) {
    var state0: UInt64 = 0x123456789ABCDEF
    var state1: UInt64 = 0x123456789ABCDEF
    if seeded {
      let file = FileHandle(forReadingAtPath: "/dev/random")!
      let seed = try! file.read(upToCount: 16)
      seed?.withUnsafeBuffer {
        (buffer: UnsafeBufferPointer<UInt64>) in
        state0 = buffer[0]
        state1 = buffer[1]
      }
    }
    self.init(state0: state0, state1: state1)
  }

  public mutating func next() -> UInt64 {
    let s1 = state0
    let s0 = state1
    state0 = s0
    let a = s1 ^ (s1 << 23)
    let b = a ^ s0
    let c = b ^ (a >> 17)
    let d = c ^ (s0 >> 26)
    state1 = d &+ s0;
    return state1
  }
}
