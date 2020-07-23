// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public class Random {
  // XorShift128Plus generator.

  private var state0: UInt64
  private var state1: UInt64

  public init(state0: UInt64 = 0x123456789ABCDEF, state1: UInt64 = 0x123456789ABCDEF) {
    self.state0 = state0
    self.state1 = state1
  }

  public convenience init(arc4Seeded: Bool) {
    var states: [UInt64] = [0x123456789ABCDEF, 0x123456789ABCDEF]
    if arc4Seeded {
      states.withUnsafeMutableBufferPointer { arc4random_buf($0.baseAddress, MemoryLayout<UInt64>.size * 2) }
    }
    self.init(state0: states[0], state1: states[1])
  }

  public func raw() -> UInt64 {
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

  public func u64(_ end: UInt64) -> UInt64 {
    // unbiased random.
    let bias_rem = ((UInt64.max % end) + 1) % end
    let max_unbiased = (UInt64.max - bias_rem)
    while true {
      let u = raw()
      if u <= max_unbiased {
        return u % end
      }
    }
  }

  public func u64(min: UInt64, end: UInt64) -> UInt64 {
    if min >= end { fatalError("Random.u64: min \(min) >= end \(end)") }
    return u64(end - min) + min
  }

  public func int(_ end: Int) -> Int {
    // unbiased random.
    return Int(u64(UInt64(end)))
  }

  public func int(min: Int, end: Int) -> Int {
    if min >= end { fatalError("Random.int: min \(min) >= end \(end)") }
    let minU = UInt64(bitPattern: Int64(min))
    let endU = UInt64(bitPattern: Int64(end))
    let rangeU = endU &- minU
    let randU = u64(rangeU)
    return Int(Int64(bitPattern: randU + minU))
  }

  public func f64(_ max: Double) -> Double {
    let endU: UInt64 = 1 << 52 // double precision has 53 digits; back off by one just to be safe.
    let u = raw() % endU // powers of two cannot be biased.
    return (Double(u) / Double(endU - 1)) * max // divide by maxU = endU - 1 to get float in range [0, 1].
  }

  public func f32(_ max: Float) -> Float {
    let endU: UInt64 = 1 << 23 // single precision has 24 digits; back off by one just to be safe.
    let u = raw() % endU // powers of two cannot be biased.
    return (Float(u) / Float(endU - 1)) * max // divide by maxU = endU - 1 to get float in range [0, 1].
  }

  public func f64(min: Double, max: Double) -> Double {
    if max <= min {
      return min
    }
    return f64(max - min) + min
  }

  public func f32(min: Float, max: Float) -> Float {
    if max <= min {
      return min
    }
    return f32(max - min) + min
  }

  public func bool() -> Bool {
    return raw() > 0x7FFF_FFFF_FFFF_FFFF
  }
}
