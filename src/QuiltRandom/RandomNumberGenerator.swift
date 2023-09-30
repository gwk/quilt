// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


import Foundation


extension RandomNumberGenerator {

  @inline(__always)
  public mutating func u64(end: UInt64) -> UInt64 {
    UInt64.random(in: 0..<end, using: &self)
  }

  @inline(__always)
  public mutating func u64(in range: Range<UInt64>) -> UInt64 {
    UInt64.random(in: range, using: &self)
  }

  @inline(__always)
  public mutating func int(end: Int) -> Int {
    Int.random(in:0..<end, using: &self)
  }

  @inline(__always)
  public mutating func int(in range: Range<Int>) -> Int {
    Int.random(in: range, using: &self)
  }

  @inline(__always)
  public mutating func f64(max: Double) -> Double {
    Double.random(in: 0...max, using: &self)
  }

  @inline(__always)
  public mutating func f64(in range: ClosedRange<Double>) -> Double {
    Double.random(in: range, using: &self)
  }

  @inline(__always)
  public mutating func f32(max: Float) -> Float {
    Float.random(in: 0...max, using: &self)
  }

  @inline(__always)
  public mutating func f32(in range: ClosedRange<Float>) -> Float {
    Float.random(in: range, using: &self)
  }

  @inline(__always)
  public mutating func bool() -> Bool {
    Bool.random(using: &self)
  }
}
