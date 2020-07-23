// © 2015 George King. Permission to use this file is granted in license-quilt.txt.
// This file is generated by gen/vec.py.

import Darwin
import simd
import QuiltArithmetic


extension SIMD4: VecType, VecType4 where Scalar: ArithmeticProtocol {
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
  public init(_ v: SIMD3<Scalar>, w: Scalar) {
    self.init(v.x, v.y, v.z, w)
  }

  public static var scalarCount: Int { return 4 }
  public static var zero: Self { return Self.init() }

  public static var unitX: SIMD4<Scalar> { return SIMD4(1, 0, 0, 0) }
  public static var unitY: SIMD4<Scalar> { return SIMD4(0, 1, 0, 0) }
  public static var unitZ: SIMD4<Scalar> { return SIMD4(0, 0, 1, 0) }
  public static var unitW: SIMD4<Scalar> { return SIMD4(0, 0, 0, 1) }

  public var vs: V4S { return V4S(x.asF32, y.asF32, z.asF32, w.asF32) }
  public var vd: V4D { return V4D(x.asF64, y.asF64, z.asF64, w.asF64) }

  public var sqrLen: F64 {
    var s = x.asF64.sqr
    s += y.asF64.sqr
    s += z.asF64.sqr
    s += w.asF64.sqr
    return s
}

  public var aspect: F64 { return x.asF64 / y.asF64 }

  public func dot(_ b: SIMD4<Scalar>) -> F64 {
    var s = x.asF64 * b.x.asF64
    s += y.asF64 * b.y.asF64
    s += z.asF64 * b.z.asF64
    s += w.asF64 * b.w.asF64
    return s
  }

}


extension SIMD4: FloatVecType where Scalar: ArithmeticFloat {

  public var allNormal: Bool { return x.isNormal && (y.isNormal && (z.isNormal && (w.isNormal))) }
  public var allFinite: Bool { return x.isFinite && (y.isFinite && (z.isFinite && (w.isFinite))) }
  public var allZero: Bool { return x.isZero && (y.isZero && (z.isZero && (w.isZero))) }
  public var anySubnormal: Bool { return x.isSubnormal || (y.isSubnormal || (z.isSubnormal || (w.isSubnormal)))}
  public var anyInfite: Bool { return x.isInfinite || (y.isInfinite || (z.isInfinite || (w.isInfinite)))}
  public var anyNaN: Bool { return x.isNaN || (y.isNaN || (z.isNaN || (w.isNaN)))}
  public var clampToUnit: SIMD4 { return SIMD4(x.clamp(min: 0, max: 1), y.clamp(min: 0, max: 1), z.clamp(min: 0, max: 1), w.clamp(min: 0, max: 1)) }
  public var clampToSignedUnit: SIMD4 { return SIMD4(x.clamp(min: -1, max: 1), y.clamp(min: -1, max: 1), z.clamp(min: -1, max: 1), w.clamp(min: -1, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8((x*255).clamp(min: 0, max: 255)), U8((y*255).clamp(min: 0, max: 255)), U8((z*255).clamp(min: 0, max: 255)), U8((w*255).clamp(min: 0, max: 255))) }

  public func cross(_ b: SIMD4) -> SIMD4 { return SIMD4(
      y * b.z - z * b.y,
      z * b.x - x * b.z,
      x * b.y - y * b.x,
    0
    )
  }
}
