// © 2015 George King. Permission to use this file is granted in license-quilt.txt.
// This file is generated by gen/vec.py.

import Darwin
import simd


extension SIMD2: VecType, VecType2 where Scalar: ArithmeticFloat {
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

  public static var unitX: SIMD2<Scalar> { return SIMD2(1, 0) }
  public static var unitY: SIMD2<Scalar> { return SIMD2(0, 1) }

  public var vs: V2S { return V2S(F32(x), F32(y)) }
  public var vd: V2D { return V2D(F64(x), F64(y)) }

  public var sqrLen: F64 {
    var s = F64(x.sqr)
    s += F64(y.sqr)
    return s
}

  public var aspect: F64 { return F64(x) / F64(y) }

  public func dot(_ b: SIMD2<Scalar>) -> F64 {
    var s = F64(x) * F64(b.x)
    s += F64(y) * F64(b.y)
    return s
  }

}


extension SIMD2 where Scalar: ArithmeticFloat {

  public var allNormal: Bool { return x.isNormal && (y.isNormal) }
  public var allFinite: Bool { return x.isFinite && (y.isFinite) }
  public var allZero: Bool { return x.isZero && (y.isZero) }
  public var anySubnormal: Bool { return x.isSubnormal || (y.isSubnormal)}
  public var anyInfite: Bool { return x.isInfinite || (y.isInfinite)}
  public var anyNaN: Bool { return x.isNaN || (y.isNaN)}
  public var clampToUnit: SIMD2 { return SIMD2(x.clamp(min: 0, max: 1), y.clamp(min: 0, max: 1)) }
  public var clampToSignedUnit: SIMD2 { return SIMD2(x.clamp(min: -1, max: 1), y.clamp(min: -1, max: 1)) }
  public var toU8Pixel: VU8Type { return VU8Type(U8((x*255).clamp(min: 0, max: 255)), U8((y*255).clamp(min: 0, max: 255))) }
}

