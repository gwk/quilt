// © 2015 George King. Permission to use this file is granted in license-quilt.txt.
// This file is generated by gen/vec.py.

import Darwin
import simd
import SceneKit
import Quilt
import QuiltUI


public typealias V4 = SCNVector4
extension V4: VecType, VecType4 {
  public typealias Scalar = Flt
  public typealias VSType = V4S
  public typealias VDType = V4D
  public typealias VU8Type = V4U8

  public init(_ v: V4S) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V4D) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V4I) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V4U8) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V3, w: Scalar) {
    self.init(v.x, v.y, v.z, w)
  }

  public static var scalarCount: Int { return 4 }

  public static var unitX: V4 { return V4(1, 0, 0, 0) }
  public static var unitY: V4 { return V4(0, 1, 0, 0) }
  public static var unitZ: V4 { return V4(0, 0, 1, 0) }
  public static var unitW: V4 { return V4(0, 0, 0, 1) }

  public var vs: V4S { return V4S(F32(x), F32(y), F32(z), F32(w)) }
  public var vd: V4D { return V4D(F64(x), F64(y), F64(z), F64(w)) }

  public var sqrLen: F64 {
    var s = F64(x.sqr)
    s += F64(y.sqr)
    s += F64(z.sqr)
    s += F64(w.sqr)
    return s }

  public var aspect: F64 { return F64(x) / F64(y) }

  public func dot(_ b: V4) -> F64 {
    var s = F64(x) * F64(b.x)
    s += F64(y) * F64(b.y)
    s += F64(z) * F64(b.z)
    s += F64(w) * F64(b.w)
    return s }
public static func +(a: V4, b: V4) -> V4 { return V4(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w) }
public static func -(a: V4, b: V4) -> V4 { return V4(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w) }
public static func *(a: V4, b: V4) -> V4 { return V4(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w) }
public static func /(a: V4, b: V4) -> V4 { return V4(a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w) }
public static func +(a: V4, s: Flt) -> V4 { return V4(a.x + s, a.y + s, a.z + s, a.w + s) }
public static func -(a: V4, s: Flt) -> V4 { return V4(a.x - s, a.y - s, a.z - s, a.w - s) }
public static func *(a: V4, s: Flt) -> V4 { return V4(a.x * s, a.y * s, a.z * s, a.w * s) }
public static func /(a: V4, s: Flt) -> V4 { return V4(a.x / s, a.y / s, a.z / s, a.w / s) }
public static prefix func -(a: V4) -> V4 { return a * -1 }

  public var allNormal: Bool { return x.isNormal && (y.isNormal && (z.isNormal && (w.isNormal))) }
  public var allFinite: Bool { return x.isFinite && (y.isFinite && (z.isFinite && (w.isFinite))) }
  public var allZero: Bool { return x.isZero && (y.isZero && (z.isZero && (w.isZero))) }
  public var anySubnormal: Bool { return x.isSubnormal || (y.isSubnormal || (z.isSubnormal || (w.isSubnormal)))}
  public var anyInfite: Bool { return x.isInfinite || (y.isInfinite || (z.isInfinite || (w.isInfinite)))}
  public var anyNaN: Bool { return x.isNaN || (y.isNaN || (z.isNaN || (w.isNaN)))}
  public var clampToUnit: V4 { return V4(x.clamp(min: 0, max: 1), y.clamp(min: 0, max: 1), z.clamp(min: 0, max: 1), w.clamp(min: 0, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8((x*255).clamp(min: 0, max: 255)), U8((y*255).clamp(min: 0, max: 255)), U8((z*255).clamp(min: 0, max: 255)), U8((w*255).clamp(min: 0, max: 255))) }

  public func cross(_ b: V4) -> V4 { return V4(
    y * b.z - z * b.y,
    z * b.x - x * b.z,
    x * b.y - y * b.x,
    0
  )}
}

extension V4: Equatable, Comparable {
  public static func ==(a: V4, b: V4) -> Bool {
    if a.x != b.x { return false }
    if a.y != b.y { return false }
    if a.z != b.z { return false }
    return a.w == b.w
  }
  public static func !=(a: V4, b: V4) -> Bool {
    if a.x == b.x { return false }
    if a.y == b.y { return false }
    if a.z == b.z { return false }
    return a.w != b.w
  }
  public static func <(a: V4, b: V4) -> Bool {
    if a.x != b.x { return a.x < b.x }
    if a.y != b.y { return a.y < b.y }
    if a.z != b.z { return a.z < b.z }
    return a.w < b.w
  }
}

extension V4: CustomStringConvertible {
  public var description: String { return "V4(\(x), \(y), \(z), \(w))" }
}

