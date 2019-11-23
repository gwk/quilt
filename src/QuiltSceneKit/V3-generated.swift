// © 2015 George King. Permission to use this file is granted in license-quilt.txt.
// This file is generated by gen/vec.py.

import Darwin
import simd
import SceneKit
import Quilt
import QuiltUI


public typealias V3 = SCNVector3
extension V3: VecType, VecType3 {
  public typealias Scalar = Flt
  public typealias VSType = V3S
  public typealias VDType = V3D
  public typealias VU8Type = V3U8

  public init(_ v: V3S) {
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
  public init(_ v: V4S) {
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

  public static var scalarCount: Int { return 3 }

  public static var unitX: V3 { return V3(1, 0, 0) }
  public static var unitY: V3 { return V3(0, 1, 0) }
  public static var unitZ: V3 { return V3(0, 0, 1) }

  public var vs: V3S { return V3S(F32(x), F32(y), F32(z)) }
  public var vd: V3D { return V3D(F64(x), F64(y), F64(z)) }

  public var sqrLen: F64 {
    var s = F64(x.sqr)
    s += F64(y.sqr)
    s += F64(z.sqr)
    return s }

  public var aspect: F64 { return F64(x) / F64(y) }

  public var r: Scalar {
    get { return x }
    set { x = newValue }
  }
  public var g: Scalar {
    get { return y }
    set { y = newValue }
  }
  public var b: Scalar {
    get { return z }
    set { z = newValue }
  }
  public func dot(_ b: V3) -> F64 {
    var s = F64(x * b.x)
    s += F64(y * b.y)
    s += F64(z * b.z)
    return s }
public static func +(a: V3, b: V3) -> V3 { return V3(a.x + b.x, a.y + b.y, a.z + b.z) }
public static func -(a: V3, b: V3) -> V3 { return V3(a.x - b.x, a.y - b.y, a.z - b.z) }
public static func *(a: V3, b: V3) -> V3 { return V3(a.x * b.x, a.y * b.y, a.z * b.z) }
public static func /(a: V3, b: V3) -> V3 { return V3(a.x / b.x, a.y / b.y, a.z / b.z) }
public static func +(a: V3, s: Flt) -> V3 { return V3(a.x + s, a.y + s, a.z + s) }
public static func -(a: V3, s: Flt) -> V3 { return V3(a.x - s, a.y - s, a.z - s) }
public static func *(a: V3, s: Flt) -> V3 { return V3(a.x * s, a.y * s, a.z * s) }
public static func /(a: V3, s: Flt) -> V3 { return V3(a.x / s, a.y / s, a.z / s) }
public static prefix func -(a: V3) -> V3 { return a * -1 }

  public var allNormal: Bool { return x.isNormal && (y.isNormal && (z.isNormal)) }
  public var allFinite: Bool { return x.isFinite && (y.isFinite && (z.isFinite)) }
  public var allZero: Bool { return x.isZero && (y.isZero && (z.isZero)) }
  public var anySubnormal: Bool { return x.isSubnormal || (y.isSubnormal || (z.isSubnormal))}
  public var anyInfite: Bool { return x.isInfinite || (y.isInfinite || (z.isInfinite))}
  public var anyNaN: Bool { return x.isNaN || (y.isNaN || (z.isNaN))}
  public var clampToUnit: V3 { return V3(x.clamp(min: 0, max: 1), y.clamp(min: 0, max: 1), z.clamp(min: 0, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8((x*255).clamp(min: 0, max: 255)), U8((y*255).clamp(min: 0, max: 255)), U8((z*255).clamp(min: 0, max: 255))) }

  public func cross(_ b: V3) -> V3 { return V3(
    y * b.z - z * b.y,
    z * b.x - x * b.z,
    x * b.y - y * b.x
  )}
}

extension V3: Equatable, Comparable {
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
  public static func <(a: V3, b: V3) -> Bool {
    if a.x != b.x { return a.x < b.x }
    if a.y != b.y { return a.y < b.y }
    return a.z < b.z
  }
}

extension V3: CustomStringConvertible {
  public var description: String { return "V3(\(x), \(y), \(z))" }
}

