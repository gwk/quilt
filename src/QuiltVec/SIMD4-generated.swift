// © 2015 George King. Permission to use this file is granted in license-quilt.txt.
// This file is generated by gen/vec.py.

import Darwin
import simd
import QuiltArithmetic


extension SIMD4: Vec, Vec4 where Scalar: ArithmeticProtocol { // Float/Int agnostic.
  public typealias VFType = V4F
  public typealias VDType = V4D
  public typealias VU8Type = V4U8

  public init(_ v: V4F) {
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
  public init(_ v: SIMD3<Scalar>, w: Scalar) {
    self.init(v.x, v.y, v.z, w)
  }

  public static var scalarCount: Int { 4 }
  public static var zero: Self { Self.init() }

  public var sqrLen: F64 {
    var s = x.asF64.sqr
    s += y.asF64.sqr
    s += z.asF64.sqr
    s += w.asF64.sqr
    return s
}

  public var aspect: F64 { x.asF64 / y.asF64 }

  public func dot(_ b: SIMD4<Scalar>) -> F64 {
    var s = x.asF64 * b.x.asF64
    s += y.asF64 * b.y.asF64
    s += z.asF64 * b.z.asF64
    s += w.asF64 * b.w.asF64
    return s
  }

}


extension SIMD4: FloatVec, FloatVec4 where Scalar: ArithmeticFloat { // Float-specific.

  public var allFinite: Bool { x.isFinite && (y.isFinite && (z.isFinite && (w.isFinite))) }
  public var allZero: Bool { x.isZero && (y.isZero && (z.isZero && (w.isZero))) }
  public var allZeroOrSubnormal: Bool { x.isZeroOrSubnormal && (y.isZeroOrSubnormal && (z.isZeroOrSubnormal && (w.isZeroOrSubnormal))) }
  public var anySubnormal: Bool { x.isSubnormal || (y.isSubnormal || (z.isSubnormal || (w.isSubnormal)))}
  public var anyInfite: Bool { x.isInfinite || (y.isInfinite || (z.isInfinite || (w.isInfinite)))}
  public var anyNaN: Bool { x.isNaN || (y.isNaN || (z.isNaN || (w.isNaN)))}
  public var anyZero: Bool { x.isZero && (y.isZero && (z.isZero && (w.isZero))) }
  public var anyZeroOrSubnormal: Bool { x.isZeroOrSubnormal || (y.isZeroOrSubnormal || (z.isZeroOrSubnormal || (w.isZeroOrSubnormal))) }
  public var clampToUnit: SIMD4 { SIMD4(x.clamp(min: 0, max: 1), y.clamp(min: 0, max: 1), z.clamp(min: 0, max: 1), w.clamp(min: 0, max: 1)) }
  public var clampToSignedUnit: SIMD4 { SIMD4(x.clamp(min: -1, max: 1), y.clamp(min: -1, max: 1), z.clamp(min: -1, max: 1), w.clamp(min: -1, max: 1)) }
  public var toU8Pixel: VU8Type { VU8Type(U8((x*255).clamp(min: 0, max: 255)), U8((y*255).clamp(min: 0, max: 255)), U8((z*255).clamp(min: 0, max: 255)), U8((w*255).clamp(min: 0, max: 255))) }

  public func cross(_ b: SIMD4) -> SIMD4 { SIMD4(
      y * b.z - z * b.y,
      z * b.x - x * b.z,
      x * b.y - y * b.x,
    0
    )
  }
}


extension SIMD4: Comparable where Scalar: Comparable{
  public static func <(a: SIMD4, b: SIMD4) -> Bool {
    if a.x != b.x { return a.x < b.x }
    if a.y != b.y { return a.y < b.y }
    if a.z != b.z { return a.z < b.z }
    return a.w < b.w
  }
}

