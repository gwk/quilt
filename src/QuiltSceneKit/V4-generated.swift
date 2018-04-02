// © 2015 George King. Permission to use this file is granted in license-quilt.txt.
// This file is generated by gen/vec.py.

import Darwin
import simd
import SceneKit
import Quilt
import QuiltUI
extension V4 : VecType4, FloatVecType, Comparable, CustomStringConvertible {
  public typealias Scalar = Flt
  public typealias FloatType = Flt
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
  public static let zero = V4(0, 0, 0, 0)
  public static let unitX = V4(1, 0, 0, 0)
  public static let unitY = V4(0, 1, 0, 0)
  public static let unitZ = V4(0, 0, 1, 0)
  public static let unitW = V4(0, 0, 0, 1)
  public var description: String { return "V4(\(x), \(y), \(z), \(w))" }
  public var vs: V4S { return V4S(F32(x), F32(y), F32(z), F32(w)) }
  public var vd: V4D { return V4D(F64(x), F64(y), F64(z), F64(w)) }
  public var sqrLen: FloatType { return (FloatType(x).sqr + FloatType(y).sqr + FloatType(z).sqr + FloatType(w).sqr) }
  public var aspect: FloatType { return FloatType(x) / FloatType(y) }
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
  public var a: Scalar {
    get { return w }
    set { w = newValue }
  }

  public var allNormal: Bool { return x.isNormal && y.isNormal && z.isNormal && w.isNormal }
  public var allFinite: Bool { return x.isFinite && y.isFinite && z.isFinite && w.isFinite }
  public var allZero: Bool { return x.isNormal && y.isNormal && z.isNormal && w.isNormal }
  public var anySubnormal: Bool { return x.isSubnormal || y.isSubnormal || z.isSubnormal || w.isSubnormal}
  public var anyInfite: Bool { return x.isInfinite || y.isInfinite || z.isInfinite || w.isInfinite}
  public var anyNaN: Bool { return x.isNaN || y.isNaN || z.isNaN || w.isNaN}
  public var norm: V4 { return self / self.len }
  public var clampToUnit: V4 { return V4(clamp(x, min: 0, max: 1), clamp(y, min: 0, max: 1), clamp(z, min: 0, max: 1), clamp(w, min: 0, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8(clamp(x * 255, min: 0, max: 255)), U8(clamp(y * 255, min: 0, max: 255)), U8(clamp(z * 255, min: 0, max: 255)), U8(clamp(w * 255, min: 0, max: 255))) }
  public var heading: Scalar { return atan2(y, x) }

  public func dot(_ b: V4) -> Scalar { return (x * b.x) + (y * b.y) + (z * b.z) + (w * b.w) }
  public func angle(_ b: V4) -> Scalar { return acos(self.dot(b) / (self.len * b.len)) }
  public func lerp(_ b: V4, _ t: Scalar) -> V4 { return self * (1 - t) + b * t }

  public func cross(_ b: V4) -> V4 { return V4(
  y * b.z - z * b.y,
  z * b.x - x * b.z,
  x * b.y - y * b.x,
  0
)}

}

public func <(a: V4, b: V4) -> Bool {
  if a.x != b.x { return a.x < b.x }
  if a.y != b.y { return a.y < b.y }
  if a.z != b.z { return a.z < b.z }
  return a.w < b.w
}

public func +(a: V4, b: V4) -> V4 { return V4(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w) }
public func -(a: V4, b: V4) -> V4 { return V4(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w) }
public func *(a: V4, b: V4) -> V4 { return V4(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w) }
public func /(a: V4, b: V4) -> V4 { return V4(a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w) }
public func +(a: V4, s: Flt) -> V4 { return V4(a.x + s, a.y + s, a.z + s, a.w + s) }
public func -(a: V4, s: Flt) -> V4 { return V4(a.x - s, a.y - s, a.z - s, a.w - s) }
public func *(a: V4, s: Flt) -> V4 { return V4(a.x * s, a.y * s, a.z * s, a.w * s) }
public func /(a: V4, s: Flt) -> V4 { return V4(a.x / s, a.y / s, a.z / s, a.w / s) }
public prefix func -(a: V4) -> V4 { return a * -1 }

