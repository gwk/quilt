// © 2015 George King. Permission to use this file is granted in license-quilt.txt.
// This file is generated by gen/vec.py.

import Darwin
import simd
import QuiltArithmetic
import CoreGraphics
import QuiltVec


extension CGVector: Vec, Vec2 { // Float/Int agnostic.
  public typealias Scalar = Flt
  public typealias VSType = V2S
  public typealias VDType = V2D
  public typealias VU8Type = V2U8

  public init(_ v: V2S) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V2D) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V2I) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V2U8) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V3S) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V3D) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V3I) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V3U8) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V4S) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V4D) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V4I) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V4U8) {
    self.init(Scalar(v.x), Scalar(v.y))
  }

  public subscript(index: Int) -> Scalar {
    get {
      switch index {
      case 0: return x
      case 1: return y
      default: fatalError("subscript out of range: \(index)")
      }
    }
    set {
      switch index {
      case 0: x = newValue
      case 1: y = newValue
      default: fatalError("subscript out of range: \(index)")
      }
    }
  }

  public static var scalarCount: Int { 2 }

  public static var unitX: CGVector { CGVector(1, 0) }
  public static var unitY: CGVector { CGVector(0, 1) }

  public var vs: V2S { V2S(x.asF32, y.asF32) }
  public var vd: V2D { V2D(x.asF64, y.asF64) }

  public var sqrLen: F64 {
    var s = x.asF64.sqr
    s += y.asF64.sqr
    return s
}

  public var aspect: F64 { x.asF64 / y.asF64 }

  public func dot(_ b: CGVector) -> F64 {
    var s = x.asF64 * b.x.asF64
    s += y.asF64 * b.y.asF64
    return s
  }

public static func +(a: CGVector, b: CGVector) -> CGVector { CGVector(a.x + b.x, a.y + b.y) }
public static func -(a: CGVector, b: CGVector) -> CGVector { CGVector(a.x - b.x, a.y - b.y) }
public static func *(a: CGVector, b: CGVector) -> CGVector { CGVector(a.x * b.x, a.y * b.y) }
public static func /(a: CGVector, b: CGVector) -> CGVector { CGVector(a.x / b.x, a.y / b.y) }
public static func +(a: CGVector, s: Flt) -> CGVector { CGVector(a.x + s, a.y + s) }
public static func -(a: CGVector, s: Flt) -> CGVector { CGVector(a.x - s, a.y - s) }
public static func *(a: CGVector, s: Flt) -> CGVector { CGVector(a.x * s, a.y * s) }
public static func /(a: CGVector, s: Flt) -> CGVector { CGVector(a.x / s, a.y / s) }
public static prefix func -(a: CGVector) -> CGVector { a * -1 }
}


extension CGVector: FloatVec, FloatVec2 { // Float-specific.

  public var allFinite: Bool { x.isFinite && (y.isFinite) }
  public var allZero: Bool { x.isZero && (y.isZero) }
  public var allZeroOrSubnormal: Bool { x.isZeroOrSubnormal && (y.isZeroOrSubnormal) }
  public var anySubnormal: Bool { x.isSubnormal || (y.isSubnormal)}
  public var anyInfite: Bool { x.isInfinite || (y.isInfinite)}
  public var anyNaN: Bool { x.isNaN || (y.isNaN)}
  public var anyZero: Bool { x.isZero && (y.isZero) }
  public var anyZeroOrSubnormal: Bool { x.isZeroOrSubnormal || (y.isZeroOrSubnormal) }
  public var clampToUnit: CGVector { CGVector(x.clamp(min: 0, max: 1), y.clamp(min: 0, max: 1)) }
  public var clampToSignedUnit: CGVector { CGVector(x.clamp(min: -1, max: 1), y.clamp(min: -1, max: 1)) }
  public var toU8Pixel: VU8Type { VU8Type(U8((x*255).clamp(min: 0, max: 255)), U8((y*255).clamp(min: 0, max: 255))) }
}


extension CGVector: Comparable {
  public static func <(a: CGVector, b: CGVector) -> Bool {
    if a.x != b.x { return a.x < b.x }
    return a.y < b.y
  }
}

extension CGVector: CustomStringConvertible {
  public var description: String { "CGVector(\(x), \(y))" }
}

