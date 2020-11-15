// © 2015 George King. Permission to use this file is granted in license-quilt.txt.
// This file is generated by gen/vec.py.

import Darwin
import simd
import QuiltArithmetic
import SceneKit
import QuiltVec
import QuiltUI


public typealias V3 = SCNVector3
extension V3: Vec, Vec3 { // Float/Int agnostic.
  public typealias Scalar = Flt
  public typealias VFType = V3F
  public typealias VDType = V3D
  public typealias VU8Type = V3U8

  public init(_ v: V3F) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z))
  }
  public init(_ v: V3D) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z))
  }
  public init(_ v: V3I) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z))
  }
  public init(_ v: V3U8) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z))
  }
  public init(_ v: V4F) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z))
  }
  public init(_ v: V4D) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z))
  }
  public init(_ v: V4I) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z))
  }
  public init(_ v: V4U8) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z))
  }
  public init(_ v: V2, z: Scalar) {
    self.init(v.x, v.y, z)
  }

  public subscript(index: Int) -> Scalar {
    get {
      switch index {
      case 0: return x
      case 1: return y
      case 2: return z
      default: fatalError("subscript out of range: \(index)")
      }
    }
    set {
      switch index {
      case 0: x = newValue
      case 1: y = newValue
      case 2: z = newValue
      default: fatalError("subscript out of range: \(index)")
      }
    }
  }

  public static var scalarCount: Int { 3 }
  public static var zero: Self { Self.init() }

  public var sqrLen: F64 {
    var s = x.asF64.sqr
    s += y.asF64.sqr
    s += z.asF64.sqr
    return s
}

  public var aspect: F64 { x.asF64 / y.asF64 }

  public func dot(_ b: V3) -> F64 {
    var s = x.asF64 * b.x.asF64
    s += y.asF64 * b.y.asF64
    s += z.asF64 * b.z.asF64
    return s
  }

public static func +(a: V3, b: V3) -> V3 { V3(a.x + b.x, a.y + b.y, a.z + b.z) }
public static func -(a: V3, b: V3) -> V3 { V3(a.x - b.x, a.y - b.y, a.z - b.z) }
public static func *(a: V3, b: V3) -> V3 { V3(a.x * b.x, a.y * b.y, a.z * b.z) }
public static func /(a: V3, b: V3) -> V3 { V3(a.x / b.x, a.y / b.y, a.z / b.z) }
public static func +(a: V3, s: Flt) -> V3 { V3(a.x + s, a.y + s, a.z + s) }
public static func -(a: V3, s: Flt) -> V3 { V3(a.x - s, a.y - s, a.z - s) }
public static func *(a: V3, s: Flt) -> V3 { V3(a.x * s, a.y * s, a.z * s) }
public static func /(a: V3, s: Flt) -> V3 { V3(a.x / s, a.y / s, a.z / s) }
public static prefix func -(a: V3) -> V3 { a * -1 }
}


extension V3: FloatVec, FloatVec3 { // Float-specific.

  public var allFinite: Bool { x.isFinite && (y.isFinite && (z.isFinite)) }
  public var allZero: Bool { x.isZero && (y.isZero && (z.isZero)) }
  public var allZeroOrSubnormal: Bool { x.isZeroOrSubnormal && (y.isZeroOrSubnormal && (z.isZeroOrSubnormal)) }
  public var anySubnormal: Bool { x.isSubnormal || (y.isSubnormal || (z.isSubnormal))}
  public var anyInfite: Bool { x.isInfinite || (y.isInfinite || (z.isInfinite))}
  public var anyNaN: Bool { x.isNaN || (y.isNaN || (z.isNaN))}
  public var anyZero: Bool { x.isZero && (y.isZero && (z.isZero)) }
  public var anyZeroOrSubnormal: Bool { x.isZeroOrSubnormal || (y.isZeroOrSubnormal || (z.isZeroOrSubnormal)) }
  public var clampToUnit: V3 { V3(x.clamp(min: 0, max: 1), y.clamp(min: 0, max: 1), z.clamp(min: 0, max: 1)) }
  public var clampToSignedUnit: V3 { V3(x.clamp(min: -1, max: 1), y.clamp(min: -1, max: 1), z.clamp(min: -1, max: 1)) }
  public var toU8Pixel: VU8Type { VU8Type(U8((x*255).clamp(min: 0, max: 255)), U8((y*255).clamp(min: 0, max: 255)), U8((z*255).clamp(min: 0, max: 255))) }

  public func cross(_ b: V3) -> V3 { V3(
      y * b.z - z * b.y,
      z * b.x - x * b.z,
      x * b.y - y * b.x
    )
  }
}


extension V3: Equatable {
  public static func ==(a: V3, b: V3) -> Bool {
    if a.x != b.x { return false }
    if a.y != b.y { return false }
    return a.z == b.z
  }
  public static func !=(a: V3, b: V3) -> Bool {
    if a.x == b.x { return false }
    if a.y == b.y { return false }
    return a.z != b.z
  }
}

extension V3: Comparable {
  public static func <(a: V3, b: V3) -> Bool {
    if a.x != b.x { return a.x < b.x }
    if a.y != b.y { return a.y < b.y }
    return a.z < b.z
  }
}

extension V3: CustomStringConvertible {
  public var description: String { "V3(\(x), \(y), \(z))" }
}

