// © 2015 George King. Permission to use this file is granted in license-quilt.txt.
// This file is generated by gen/vec.py.

import Darwin
import simd
import CoreGraphics
import Quilt


public typealias V2 = CGPoint
extension V2: VecType, VecType2 {
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

  public static var scalarCount: Int { return 2 }

  public static var unitX: V2 { return V2(1, 0) }
  public static var unitY: V2 { return V2(0, 1) }

  public var vs: V2S { return V2S(F32(x), F32(y)) }
  public var vd: V2D { return V2D(F64(x), F64(y)) }

  public var sqrLen: F64 {
    var s = F64(x.sqr)
    s += F64(y.sqr)
    return s }

  public var aspect: F64 { return F64(x) / F64(y) }

  public func dot(_ b: V2) -> F64 {
    var s = F64(x) * F64(b.x)
    s += F64(y) * F64(b.y)
    return s }
public static func +(a: V2, b: V2) -> V2 { return V2(a.x + b.x, a.y + b.y) }
public static func -(a: V2, b: V2) -> V2 { return V2(a.x - b.x, a.y - b.y) }
public static func *(a: V2, b: V2) -> V2 { return V2(a.x * b.x, a.y * b.y) }
public static func /(a: V2, b: V2) -> V2 { return V2(a.x / b.x, a.y / b.y) }
public static func +(a: V2, s: Flt) -> V2 { return V2(a.x + s, a.y + s) }
public static func -(a: V2, s: Flt) -> V2 { return V2(a.x - s, a.y - s) }
public static func *(a: V2, s: Flt) -> V2 { return V2(a.x * s, a.y * s) }
public static func /(a: V2, s: Flt) -> V2 { return V2(a.x / s, a.y / s) }
public static prefix func -(a: V2) -> V2 { return a * -1 }

  public var allNormal: Bool { return x.isNormal && (y.isNormal) }
  public var allFinite: Bool { return x.isFinite && (y.isFinite) }
  public var allZero: Bool { return x.isZero && (y.isZero) }
  public var anySubnormal: Bool { return x.isSubnormal || (y.isSubnormal)}
  public var anyInfite: Bool { return x.isInfinite || (y.isInfinite)}
  public var anyNaN: Bool { return x.isNaN || (y.isNaN)}
  public var clampToUnit: V2 { return V2(x.clamp(min: 0, max: 1), y.clamp(min: 0, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8((x*255).clamp(min: 0, max: 255)), U8((y*255).clamp(min: 0, max: 255))) }
}

extension V2: CustomStringConvertible {
  public var description: String { return "V2(\(x), \(y))" }
}

