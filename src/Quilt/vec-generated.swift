// © 2015 George King. Permission to use this file is granted in license-quilt.txt.
// This file is generated by gen/vec.py.
  
import Darwin
import simd


public typealias V2S = float2

extension V2S : VecType2, FloatVecType, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = F32
  public typealias FloatType = F32
  public typealias VSType = V2S
  public typealias VDType = V2D
  public typealias VU8Type = V2U8
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
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(F32.self), try c.decode(F32.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 2 {
      throw Json.Err.unexpectedCount(expCount: 2, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as F32, try jsonArray.el(1).conv() as F32)
  }

  public static let zero = V2S(0, 0)
  public static let unitX = V2S(1, 0)
  public static let unitY = V2S(0, 1)
  public var description: String { return "V2S(\(x), \(y))" }
  public var vs: V2S { return V2S(F32(x), F32(y)) }
  public var vd: V2D { return V2D(F64(x), F64(y)) }
  public var sqrLen: FloatType { return (FloatType(x).sqr + FloatType(y).sqr) }
  public var aspect: FloatType { return FloatType(x) / FloatType(y) }
  public var l: Scalar {
    get { return x }
    set { x = newValue }
  }
  public var a: Scalar {
    get { return y }
    set { y = newValue }
  }

  public var allNormal: Bool { return x.isNormal && y.isNormal }
  public var allFinite: Bool { return x.isFinite && y.isFinite }
  public var allZero: Bool { return x.isNormal && y.isNormal }
  public var anySubnormal: Bool { return x.isSubnormal || y.isSubnormal}
  public var anyInfite: Bool { return x.isInfinite || y.isInfinite}
  public var anyNaN: Bool { return x.isNaN || y.isNaN}
  public var norm: V2S { return self / self.len }
  public var clampToUnit: V2S { return V2S(clamp(x, min: 0, max: 1), clamp(y, min: 0, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8(clamp(x * 255, min: 0, max: 255)), U8(clamp(y * 255, min: 0, max: 255))) }
  public var heading: Scalar { return atan2(y, x) }

  public func dot(_ b: V2S) -> Scalar { return (x * b.x) + (y * b.y) }
  public func angle(_ b: V2S) -> Scalar { return acos(self.dot(b) / (self.len * b.len)) }
  public func lerp(_ b: V2S, _ t: Scalar) -> V2S { return self * (1 - t) + b * t }

}

public prefix func -(a: V2S) -> V2S { return a * -1 }


public typealias V2D = double2

extension V2D : VecType2, FloatVecType, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = F64
  public typealias FloatType = F64
  public typealias VSType = V2S
  public typealias VDType = V2D
  public typealias VU8Type = V2U8
  public init(_ v: V2S) {
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
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(F64.self), try c.decode(F64.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 2 {
      throw Json.Err.unexpectedCount(expCount: 2, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as F64, try jsonArray.el(1).conv() as F64)
  }

  public static let zero = V2D(0, 0)
  public static let unitX = V2D(1, 0)
  public static let unitY = V2D(0, 1)
  public var description: String { return "V2D(\(x), \(y))" }
  public var vs: V2S { return V2S(F32(x), F32(y)) }
  public var vd: V2D { return V2D(F64(x), F64(y)) }
  public var sqrLen: FloatType { return (FloatType(x).sqr + FloatType(y).sqr) }
  public var aspect: FloatType { return FloatType(x) / FloatType(y) }
  public var l: Scalar {
    get { return x }
    set { x = newValue }
  }
  public var a: Scalar {
    get { return y }
    set { y = newValue }
  }

  public var allNormal: Bool { return x.isNormal && y.isNormal }
  public var allFinite: Bool { return x.isFinite && y.isFinite }
  public var allZero: Bool { return x.isNormal && y.isNormal }
  public var anySubnormal: Bool { return x.isSubnormal || y.isSubnormal}
  public var anyInfite: Bool { return x.isInfinite || y.isInfinite}
  public var anyNaN: Bool { return x.isNaN || y.isNaN}
  public var norm: V2D { return self / self.len }
  public var clampToUnit: V2D { return V2D(clamp(x, min: 0, max: 1), clamp(y, min: 0, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8(clamp(x * 255, min: 0, max: 255)), U8(clamp(y * 255, min: 0, max: 255))) }
  public var heading: Scalar { return atan2(y, x) }

  public func dot(_ b: V2D) -> Scalar { return (x * b.x) + (y * b.y) }
  public func angle(_ b: V2D) -> Scalar { return acos(self.dot(b) / (self.len * b.len)) }
  public func lerp(_ b: V2D, _ t: Scalar) -> V2D { return self * (1 - t) + b * t }

}

public prefix func -(a: V2D) -> V2D { return a * -1 }


public struct V2I : VecType2, IntVecType, Equatable, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = Int
  public typealias FloatType = F64
  public typealias VSType = V2S
  public typealias VDType = V2D
  public typealias VU8Type = V2U8
  public var x: Scalar
  public var y: Scalar
  public init(_ x: Scalar, _ y: Scalar) {
    self.x = x
    self.y = y
  }
  public init() { self.init(0, 0) }
  public init(_ v: V2S) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V2D) {
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
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(Int.self), try c.decode(Int.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 2 {
      throw Json.Err.unexpectedCount(expCount: 2, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as Int, try jsonArray.el(1).conv() as Int)
  }

  public static let zero = V2I(0, 0)
  public static let unitX = V2I(1, 0)
  public static let unitY = V2I(0, 1)
  public var description: String { return "V2I(\(x), \(y))" }
  public var vs: V2S { return V2S(F32(x), F32(y)) }
  public var vd: V2D { return V2D(F64(x), F64(y)) }
  public var sqrLen: FloatType { return (FloatType(x).sqr + FloatType(y).sqr) }
  public var aspect: FloatType { return FloatType(x) / FloatType(y) }
  public var l: Scalar {
    get { return x }
    set { x = newValue }
  }
  public var a: Scalar {
    get { return y }
    set { y = newValue }
  }
}

public func +(a: V2I, b: V2I) -> V2I { return V2I(a.x + b.x, a.y + b.y) }
public func -(a: V2I, b: V2I) -> V2I { return V2I(a.x - b.x, a.y - b.y) }
public func *(a: V2I, b: V2I) -> V2I { return V2I(a.x * b.x, a.y * b.y) }
public func /(a: V2I, b: V2I) -> V2I { return V2I(a.x / b.x, a.y / b.y) }
public func +(a: V2I, s: Int) -> V2I { return V2I(a.x + s, a.y + s) }
public func -(a: V2I, s: Int) -> V2I { return V2I(a.x - s, a.y - s) }
public func *(a: V2I, s: Int) -> V2I { return V2I(a.x * s, a.y * s) }
public func /(a: V2I, s: Int) -> V2I { return V2I(a.x / s, a.y / s) }
public prefix func -(a: V2I) -> V2I { return a * -1 }

public func ==(a: V2I, b: V2I) -> Bool {
  return a.x == b.x && a.y == b.y
}


public struct V2U8 : VecType2, IntVecType, Equatable, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = U8
  public typealias FloatType = F32
  public typealias VSType = V2S
  public typealias VDType = V2D
  public typealias VU8Type = V2U8
  public var x: Scalar
  public var y: Scalar
  public init(_ x: Scalar, _ y: Scalar) {
    self.x = x
    self.y = y
  }
  public init() { self.init(0, 0) }
  public init(_ v: V2S) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V2D) {
    self.init(Scalar(v.x), Scalar(v.y))
  }
  public init(_ v: V2I) {
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
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(U8.self), try c.decode(U8.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 2 {
      throw Json.Err.unexpectedCount(expCount: 2, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as U8, try jsonArray.el(1).conv() as U8)
  }

  public static let zero = V2U8(0, 0)
  public static let unitX = V2U8(1, 0)
  public static let unitY = V2U8(0, 1)
  public var description: String { return "V2U8(\(x), \(y))" }
  public var vs: V2S { return V2S(F32(x), F32(y)) }
  public var vd: V2D { return V2D(F64(x), F64(y)) }
  public var sqrLen: FloatType { return (FloatType(x).sqr + FloatType(y).sqr) }
  public var aspect: FloatType { return FloatType(x) / FloatType(y) }
  public var l: Scalar {
    get { return x }
    set { x = newValue }
  }
  public var a: Scalar {
    get { return y }
    set { y = newValue }
  }
  public var toSPixel: VSType { return VSType(F32(x) / F32(0xFF), F32(y) / F32(0xFF)) }
}

public func +(a: V2U8, b: V2U8) -> V2U8 { return V2U8(a.x + b.x, a.y + b.y) }
public func -(a: V2U8, b: V2U8) -> V2U8 { return V2U8(a.x - b.x, a.y - b.y) }
public func *(a: V2U8, b: V2U8) -> V2U8 { return V2U8(a.x * b.x, a.y * b.y) }
public func /(a: V2U8, b: V2U8) -> V2U8 { return V2U8(a.x / b.x, a.y / b.y) }
public func +(a: V2U8, s: U8) -> V2U8 { return V2U8(a.x + s, a.y + s) }
public func -(a: V2U8, s: U8) -> V2U8 { return V2U8(a.x - s, a.y - s) }
public func *(a: V2U8, s: U8) -> V2U8 { return V2U8(a.x * s, a.y * s) }
public func /(a: V2U8, s: U8) -> V2U8 { return V2U8(a.x / s, a.y / s) }

public func ==(a: V2U8, b: V2U8) -> Bool {
  return a.x == b.x && a.y == b.y
}


public typealias V3S = float3

extension V3S : VecType3, FloatVecType, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = F32
  public typealias FloatType = F32
  public typealias VSType = V3S
  public typealias VDType = V3D
  public typealias VU8Type = V3U8
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
  public init(_ v: V2S, z: Scalar) {
    self.init(v.x, v.y, z)
  }
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(F32.self), try c.decode(F32.self), try c.decode(F32.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 3 {
      throw Json.Err.unexpectedCount(expCount: 3, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as F32, try jsonArray.el(1).conv() as F32, try jsonArray.el(2).conv() as F32)
  }

  public static let zero = V3S(0, 0, 0)
  public static let unitX = V3S(1, 0, 0)
  public static let unitY = V3S(0, 1, 0)
  public static let unitZ = V3S(0, 0, 1)
  public var description: String { return "V3S(\(x), \(y), \(z))" }
  public var vs: V3S { return V3S(F32(x), F32(y), F32(z)) }
  public var vd: V3D { return V3D(F64(x), F64(y), F64(z)) }
  public var sqrLen: FloatType { return (FloatType(x).sqr + FloatType(y).sqr + FloatType(z).sqr) }
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

  public var allNormal: Bool { return x.isNormal && y.isNormal && z.isNormal }
  public var allFinite: Bool { return x.isFinite && y.isFinite && z.isFinite }
  public var allZero: Bool { return x.isNormal && y.isNormal && z.isNormal }
  public var anySubnormal: Bool { return x.isSubnormal || y.isSubnormal || z.isSubnormal}
  public var anyInfite: Bool { return x.isInfinite || y.isInfinite || z.isInfinite}
  public var anyNaN: Bool { return x.isNaN || y.isNaN || z.isNaN}
  public var norm: V3S { return self / self.len }
  public var clampToUnit: V3S { return V3S(clamp(x, min: 0, max: 1), clamp(y, min: 0, max: 1), clamp(z, min: 0, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8(clamp(x * 255, min: 0, max: 255)), U8(clamp(y * 255, min: 0, max: 255)), U8(clamp(z * 255, min: 0, max: 255))) }
  public var heading: Scalar { return atan2(y, x) }

  public func dot(_ b: V3S) -> Scalar { return (x * b.x) + (y * b.y) + (z * b.z) }
  public func angle(_ b: V3S) -> Scalar { return acos(self.dot(b) / (self.len * b.len)) }
  public func lerp(_ b: V3S, _ t: Scalar) -> V3S { return self * (1 - t) + b * t }

  public func cross(_ b: V3S) -> V3S { return V3S(
  y * b.z - z * b.y,
  z * b.x - x * b.z,
  x * b.y - y * b.x
)}

}

public prefix func -(a: V3S) -> V3S { return a * -1 }


public typealias V3D = double3

extension V3D : VecType3, FloatVecType, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = F64
  public typealias FloatType = F64
  public typealias VSType = V3S
  public typealias VDType = V3D
  public typealias VU8Type = V3U8
  public init(_ v: V3S) {
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
  public init(_ v: V2D, z: Scalar) {
    self.init(v.x, v.y, z)
  }
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(F64.self), try c.decode(F64.self), try c.decode(F64.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 3 {
      throw Json.Err.unexpectedCount(expCount: 3, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as F64, try jsonArray.el(1).conv() as F64, try jsonArray.el(2).conv() as F64)
  }

  public static let zero = V3D(0, 0, 0)
  public static let unitX = V3D(1, 0, 0)
  public static let unitY = V3D(0, 1, 0)
  public static let unitZ = V3D(0, 0, 1)
  public var description: String { return "V3D(\(x), \(y), \(z))" }
  public var vs: V3S { return V3S(F32(x), F32(y), F32(z)) }
  public var vd: V3D { return V3D(F64(x), F64(y), F64(z)) }
  public var sqrLen: FloatType { return (FloatType(x).sqr + FloatType(y).sqr + FloatType(z).sqr) }
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

  public var allNormal: Bool { return x.isNormal && y.isNormal && z.isNormal }
  public var allFinite: Bool { return x.isFinite && y.isFinite && z.isFinite }
  public var allZero: Bool { return x.isNormal && y.isNormal && z.isNormal }
  public var anySubnormal: Bool { return x.isSubnormal || y.isSubnormal || z.isSubnormal}
  public var anyInfite: Bool { return x.isInfinite || y.isInfinite || z.isInfinite}
  public var anyNaN: Bool { return x.isNaN || y.isNaN || z.isNaN}
  public var norm: V3D { return self / self.len }
  public var clampToUnit: V3D { return V3D(clamp(x, min: 0, max: 1), clamp(y, min: 0, max: 1), clamp(z, min: 0, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8(clamp(x * 255, min: 0, max: 255)), U8(clamp(y * 255, min: 0, max: 255)), U8(clamp(z * 255, min: 0, max: 255))) }
  public var heading: Scalar { return atan2(y, x) }

  public func dot(_ b: V3D) -> Scalar { return (x * b.x) + (y * b.y) + (z * b.z) }
  public func angle(_ b: V3D) -> Scalar { return acos(self.dot(b) / (self.len * b.len)) }
  public func lerp(_ b: V3D, _ t: Scalar) -> V3D { return self * (1 - t) + b * t }

  public func cross(_ b: V3D) -> V3D { return V3D(
  y * b.z - z * b.y,
  z * b.x - x * b.z,
  x * b.y - y * b.x
)}

}

public prefix func -(a: V3D) -> V3D { return a * -1 }


public struct V3I : VecType3, IntVecType, Equatable, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = Int
  public typealias FloatType = F64
  public typealias VSType = V3S
  public typealias VDType = V3D
  public typealias VU8Type = V3U8
  public var x: Scalar
  public var y: Scalar
  public var z: Scalar
  public init(_ x: Scalar, _ y: Scalar, _ z: Scalar) {
    self.x = x
    self.y = y
    self.z = z
  }
  public init() { self.init(0, 0, 0) }
  public init(_ v: V3S) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z))
  }
  public init(_ v: V3D) {
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
  public init(_ v: V2I, z: Scalar) {
    self.init(v.x, v.y, z)
  }
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(Int.self), try c.decode(Int.self), try c.decode(Int.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 3 {
      throw Json.Err.unexpectedCount(expCount: 3, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as Int, try jsonArray.el(1).conv() as Int, try jsonArray.el(2).conv() as Int)
  }

  public static let zero = V3I(0, 0, 0)
  public static let unitX = V3I(1, 0, 0)
  public static let unitY = V3I(0, 1, 0)
  public static let unitZ = V3I(0, 0, 1)
  public var description: String { return "V3I(\(x), \(y), \(z))" }
  public var vs: V3S { return V3S(F32(x), F32(y), F32(z)) }
  public var vd: V3D { return V3D(F64(x), F64(y), F64(z)) }
  public var sqrLen: FloatType { return (FloatType(x).sqr + FloatType(y).sqr + FloatType(z).sqr) }
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
}

public func +(a: V3I, b: V3I) -> V3I { return V3I(a.x + b.x, a.y + b.y, a.z + b.z) }
public func -(a: V3I, b: V3I) -> V3I { return V3I(a.x - b.x, a.y - b.y, a.z - b.z) }
public func *(a: V3I, b: V3I) -> V3I { return V3I(a.x * b.x, a.y * b.y, a.z * b.z) }
public func /(a: V3I, b: V3I) -> V3I { return V3I(a.x / b.x, a.y / b.y, a.z / b.z) }
public func +(a: V3I, s: Int) -> V3I { return V3I(a.x + s, a.y + s, a.z + s) }
public func -(a: V3I, s: Int) -> V3I { return V3I(a.x - s, a.y - s, a.z - s) }
public func *(a: V3I, s: Int) -> V3I { return V3I(a.x * s, a.y * s, a.z * s) }
public func /(a: V3I, s: Int) -> V3I { return V3I(a.x / s, a.y / s, a.z / s) }
public prefix func -(a: V3I) -> V3I { return a * -1 }

public func ==(a: V3I, b: V3I) -> Bool {
  return a.x == b.x && a.y == b.y && a.z == b.z
}


public struct V3U8 : VecType3, IntVecType, Equatable, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = U8
  public typealias FloatType = F32
  public typealias VSType = V3S
  public typealias VDType = V3D
  public typealias VU8Type = V3U8
  public var x: Scalar
  public var y: Scalar
  public var z: Scalar
  public init(_ x: Scalar, _ y: Scalar, _ z: Scalar) {
    self.x = x
    self.y = y
    self.z = z
  }
  public init() { self.init(0, 0, 0) }
  public init(_ v: V3S) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z))
  }
  public init(_ v: V3D) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z))
  }
  public init(_ v: V3I) {
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
  public init(_ v: V2U8, z: Scalar) {
    self.init(v.x, v.y, z)
  }
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(U8.self), try c.decode(U8.self), try c.decode(U8.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 3 {
      throw Json.Err.unexpectedCount(expCount: 3, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as U8, try jsonArray.el(1).conv() as U8, try jsonArray.el(2).conv() as U8)
  }

  public static let zero = V3U8(0, 0, 0)
  public static let unitX = V3U8(1, 0, 0)
  public static let unitY = V3U8(0, 1, 0)
  public static let unitZ = V3U8(0, 0, 1)
  public var description: String { return "V3U8(\(x), \(y), \(z))" }
  public var vs: V3S { return V3S(F32(x), F32(y), F32(z)) }
  public var vd: V3D { return V3D(F64(x), F64(y), F64(z)) }
  public var sqrLen: FloatType { return (FloatType(x).sqr + FloatType(y).sqr + FloatType(z).sqr) }
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
  public var toSPixel: VSType { return VSType(F32(x) / F32(0xFF), F32(y) / F32(0xFF), F32(z) / F32(0xFF)) }
}

public func +(a: V3U8, b: V3U8) -> V3U8 { return V3U8(a.x + b.x, a.y + b.y, a.z + b.z) }
public func -(a: V3U8, b: V3U8) -> V3U8 { return V3U8(a.x - b.x, a.y - b.y, a.z - b.z) }
public func *(a: V3U8, b: V3U8) -> V3U8 { return V3U8(a.x * b.x, a.y * b.y, a.z * b.z) }
public func /(a: V3U8, b: V3U8) -> V3U8 { return V3U8(a.x / b.x, a.y / b.y, a.z / b.z) }
public func +(a: V3U8, s: U8) -> V3U8 { return V3U8(a.x + s, a.y + s, a.z + s) }
public func -(a: V3U8, s: U8) -> V3U8 { return V3U8(a.x - s, a.y - s, a.z - s) }
public func *(a: V3U8, s: U8) -> V3U8 { return V3U8(a.x * s, a.y * s, a.z * s) }
public func /(a: V3U8, s: U8) -> V3U8 { return V3U8(a.x / s, a.y / s, a.z / s) }

public func ==(a: V3U8, b: V3U8) -> Bool {
  return a.x == b.x && a.y == b.y && a.z == b.z
}


public typealias V4S = float4

extension V4S : VecType4, FloatVecType, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = F32
  public typealias FloatType = F32
  public typealias VSType = V4S
  public typealias VDType = V4D
  public typealias VU8Type = V4U8
  public init(_ v: V4D) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V4I) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V4U8) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V3S, w: Scalar) {
    self.init(v.x, v.y, v.z, w)
  }
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(F32.self), try c.decode(F32.self), try c.decode(F32.self), try c.decode(F32.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 4 {
      throw Json.Err.unexpectedCount(expCount: 4, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as F32, try jsonArray.el(1).conv() as F32, try jsonArray.el(2).conv() as F32, try jsonArray.el(3).conv() as F32)
  }

  public static let zero = V4S(0, 0, 0, 0)
  public static let unitX = V4S(1, 0, 0, 0)
  public static let unitY = V4S(0, 1, 0, 0)
  public static let unitZ = V4S(0, 0, 1, 0)
  public static let unitW = V4S(0, 0, 0, 1)
  public var description: String { return "V4S(\(x), \(y), \(z), \(w))" }
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
  public var norm: V4S { return self / self.len }
  public var clampToUnit: V4S { return V4S(clamp(x, min: 0, max: 1), clamp(y, min: 0, max: 1), clamp(z, min: 0, max: 1), clamp(w, min: 0, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8(clamp(x * 255, min: 0, max: 255)), U8(clamp(y * 255, min: 0, max: 255)), U8(clamp(z * 255, min: 0, max: 255)), U8(clamp(w * 255, min: 0, max: 255))) }
  public var heading: Scalar { return atan2(y, x) }

  public func dot(_ b: V4S) -> Scalar { return (x * b.x) + (y * b.y) + (z * b.z) + (w * b.w) }
  public func angle(_ b: V4S) -> Scalar { return acos(self.dot(b) / (self.len * b.len)) }
  public func lerp(_ b: V4S, _ t: Scalar) -> V4S { return self * (1 - t) + b * t }

  public func cross(_ b: V4S) -> V4S { return V4S(
  y * b.z - z * b.y,
  z * b.x - x * b.z,
  x * b.y - y * b.x,
  0
)}

}

public prefix func -(a: V4S) -> V4S { return a * -1 }


public typealias V4D = double4

extension V4D : VecType4, FloatVecType, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = F64
  public typealias FloatType = F64
  public typealias VSType = V4S
  public typealias VDType = V4D
  public typealias VU8Type = V4U8
  public init(_ v: V4S) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V4I) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V4U8) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V3D, w: Scalar) {
    self.init(v.x, v.y, v.z, w)
  }
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(F64.self), try c.decode(F64.self), try c.decode(F64.self), try c.decode(F64.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 4 {
      throw Json.Err.unexpectedCount(expCount: 4, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as F64, try jsonArray.el(1).conv() as F64, try jsonArray.el(2).conv() as F64, try jsonArray.el(3).conv() as F64)
  }

  public static let zero = V4D(0, 0, 0, 0)
  public static let unitX = V4D(1, 0, 0, 0)
  public static let unitY = V4D(0, 1, 0, 0)
  public static let unitZ = V4D(0, 0, 1, 0)
  public static let unitW = V4D(0, 0, 0, 1)
  public var description: String { return "V4D(\(x), \(y), \(z), \(w))" }
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
  public var norm: V4D { return self / self.len }
  public var clampToUnit: V4D { return V4D(clamp(x, min: 0, max: 1), clamp(y, min: 0, max: 1), clamp(z, min: 0, max: 1), clamp(w, min: 0, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8(clamp(x * 255, min: 0, max: 255)), U8(clamp(y * 255, min: 0, max: 255)), U8(clamp(z * 255, min: 0, max: 255)), U8(clamp(w * 255, min: 0, max: 255))) }
  public var heading: Scalar { return atan2(y, x) }

  public func dot(_ b: V4D) -> Scalar { return (x * b.x) + (y * b.y) + (z * b.z) + (w * b.w) }
  public func angle(_ b: V4D) -> Scalar { return acos(self.dot(b) / (self.len * b.len)) }
  public func lerp(_ b: V4D, _ t: Scalar) -> V4D { return self * (1 - t) + b * t }

  public func cross(_ b: V4D) -> V4D { return V4D(
  y * b.z - z * b.y,
  z * b.x - x * b.z,
  x * b.y - y * b.x,
  0
)}

}

public prefix func -(a: V4D) -> V4D { return a * -1 }


public struct V4I : VecType4, IntVecType, Equatable, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = Int
  public typealias FloatType = F64
  public typealias VSType = V4S
  public typealias VDType = V4D
  public typealias VU8Type = V4U8
  public var x: Scalar
  public var y: Scalar
  public var z: Scalar
  public var w: Scalar
  public init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar) {
    self.x = x
    self.y = y
    self.z = z
    self.w = w
  }
  public init() { self.init(0, 0, 0, 0) }
  public init(_ v: V4S) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V4D) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V4U8) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V3I, w: Scalar) {
    self.init(v.x, v.y, v.z, w)
  }
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(Int.self), try c.decode(Int.self), try c.decode(Int.self), try c.decode(Int.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 4 {
      throw Json.Err.unexpectedCount(expCount: 4, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as Int, try jsonArray.el(1).conv() as Int, try jsonArray.el(2).conv() as Int, try jsonArray.el(3).conv() as Int)
  }

  public static let zero = V4I(0, 0, 0, 0)
  public static let unitX = V4I(1, 0, 0, 0)
  public static let unitY = V4I(0, 1, 0, 0)
  public static let unitZ = V4I(0, 0, 1, 0)
  public static let unitW = V4I(0, 0, 0, 1)
  public var description: String { return "V4I(\(x), \(y), \(z), \(w))" }
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
}

public func +(a: V4I, b: V4I) -> V4I { return V4I(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w) }
public func -(a: V4I, b: V4I) -> V4I { return V4I(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w) }
public func *(a: V4I, b: V4I) -> V4I { return V4I(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w) }
public func /(a: V4I, b: V4I) -> V4I { return V4I(a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w) }
public func +(a: V4I, s: Int) -> V4I { return V4I(a.x + s, a.y + s, a.z + s, a.w + s) }
public func -(a: V4I, s: Int) -> V4I { return V4I(a.x - s, a.y - s, a.z - s, a.w - s) }
public func *(a: V4I, s: Int) -> V4I { return V4I(a.x * s, a.y * s, a.z * s, a.w * s) }
public func /(a: V4I, s: Int) -> V4I { return V4I(a.x / s, a.y / s, a.z / s, a.w / s) }
public prefix func -(a: V4I) -> V4I { return a * -1 }

public func ==(a: V4I, b: V4I) -> Bool {
  return a.x == b.x && a.y == b.y && a.z == b.z && a.w == b.w
}


public struct V4U8 : VecType4, IntVecType, Equatable, CustomStringConvertible, JsonArrayInitable, Decodable {
  public typealias Scalar = U8
  public typealias FloatType = F32
  public typealias VSType = V4S
  public typealias VDType = V4D
  public typealias VU8Type = V4U8
  public var x: Scalar
  public var y: Scalar
  public var z: Scalar
  public var w: Scalar
  public init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar) {
    self.x = x
    self.y = y
    self.z = z
    self.w = w
  }
  public init() { self.init(0, 0, 0, 0) }
  public init(_ v: V4S) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V4D) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V4I) {
    self.init(Scalar(v.x), Scalar(v.y), Scalar(v.z), Scalar(v.w))
  }
  public init(_ v: V3U8, w: Scalar) {
    self.init(v.x, v.y, v.z, w)
  }
  public init(from decoder: Decoder) throws {
    var c = try decoder.unkeyedContainer()
    self.init(try c.decode(U8.self), try c.decode(U8.self), try c.decode(U8.self), try c.decode(U8.self))
  }
  public init(jsonArray: JsonArray) throws {
    if jsonArray.count != 4 {
      throw Json.Err.unexpectedCount(expCount: 4, json: jsonArray.raw)
    }
    self.init(try jsonArray.el(0).conv() as U8, try jsonArray.el(1).conv() as U8, try jsonArray.el(2).conv() as U8, try jsonArray.el(3).conv() as U8)
  }

  public static let zero = V4U8(0, 0, 0, 0)
  public static let unitX = V4U8(1, 0, 0, 0)
  public static let unitY = V4U8(0, 1, 0, 0)
  public static let unitZ = V4U8(0, 0, 1, 0)
  public static let unitW = V4U8(0, 0, 0, 1)
  public var description: String { return "V4U8(\(x), \(y), \(z), \(w))" }
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
  public var toSPixel: VSType { return VSType(F32(x) / F32(0xFF), F32(y) / F32(0xFF), F32(z) / F32(0xFF), F32(w) / F32(0xFF)) }
}

public func +(a: V4U8, b: V4U8) -> V4U8 { return V4U8(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w) }
public func -(a: V4U8, b: V4U8) -> V4U8 { return V4U8(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w) }
public func *(a: V4U8, b: V4U8) -> V4U8 { return V4U8(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w) }
public func /(a: V4U8, b: V4U8) -> V4U8 { return V4U8(a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w) }
public func +(a: V4U8, s: U8) -> V4U8 { return V4U8(a.x + s, a.y + s, a.z + s, a.w + s) }
public func -(a: V4U8, s: U8) -> V4U8 { return V4U8(a.x - s, a.y - s, a.z - s, a.w - s) }
public func *(a: V4U8, s: U8) -> V4U8 { return V4U8(a.x * s, a.y * s, a.z * s, a.w * s) }
public func /(a: V4U8, s: U8) -> V4U8 { return V4U8(a.x / s, a.y / s, a.z / s, a.w / s) }

public func ==(a: V4U8, b: V4U8) -> Bool {
  return a.x == b.x && a.y == b.y && a.z == b.z && a.w == b.w
}

