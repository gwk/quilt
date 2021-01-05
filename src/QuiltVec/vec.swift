// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


import Foundation
import simd
import QuiltArithmetic

// V2.
public typealias V2F = SIMD2<F32>
public typealias V2D = SIMD2<F64>

public typealias V2I = SIMD2<Int>

public typealias V2I8 = SIMD2<I8>
public typealias V2I16 = SIMD2<I16>
public typealias V2I32 = SIMD2<I32>

public typealias V2U8 = SIMD2<U8>
public typealias V2U16 = SIMD2<U16>
public typealias V2U32 = SIMD2<U32>


// V3.
public typealias V3F = SIMD3<F32>
public typealias V3D = SIMD3<F64>

public typealias V3I = SIMD3<Int>

public typealias V3I8 = SIMD3<I8>
public typealias V3I16 = SIMD3<I16>
public typealias V3I32 = SIMD3<I32>

public typealias V3U8 = SIMD3<U8>
public typealias V3U16 = SIMD3<U16>
public typealias V3U32 = SIMD3<U32>


// V4.
public typealias V4F = SIMD4<F32>
public typealias V4D = SIMD4<F64>

public typealias V4I = SIMD4<Int>

public typealias V4I8 = SIMD4<I8>
public typealias V4I16 = SIMD4<I16>
public typealias V4I32 = SIMD4<I32>

public typealias V4U8 = SIMD4<U8>
public typealias V4U16 = SIMD4<U16>
public typealias V4U32 = SIMD4<U32>



// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin
import QuiltArithmetic


public protocol Vec: Equatable, CustomStringConvertible {
  associatedtype Scalar: ArithmeticProtocol
  associatedtype VFType: FloatVec where VFType.Scalar == F32
  associatedtype VDType: FloatVec where VDType.Scalar == F64
  associatedtype V2Type: Vec2 where V2Type.Scalar == Scalar

  init()
  init(_ v: VFType)
  init(_ v: VDType)
  init(scalar: Scalar)

  static var zero: Self { get }
  static var one: Self { get }

  static var scalarCount: Int { get }

  subscript(index: Int) -> Scalar { get set }

  var x: Scalar { get }
  var y: Scalar { get }
  var vf: VFType { get }
  var vd: VDType { get }
  var sqrLen: F64 { get }

  func dot(_ b: Self) -> F64
}


extension Vec {

  public var len: F64 { sqrLen.sqrt }
  public var aspect: F64 { x.asF64 / y.asF64 }
  public var heading: F64 { atan2(y.asF64, x.asF64) }

  public func angle(_ b: Self) -> F64 { acos(self.dot(b) / (self.len * b.len)) }
}


public protocol Vec2: Vec {
  init(_ x: Scalar, _ y: Scalar)
  var x: Scalar { get set }
  var y: Scalar { get set }
}

public extension Vec2 {
  init(scalar: Scalar) { self.init(scalar, scalar) }

  static var one: Self { return Self(1, 1) }
  static var unitX: Self { Self(1, 0) }
  static var unitY: Self { Self(0, 1) }

  var vf: V2F { V2F(x.asF32, y.asF32) }
  var vd: V2D { V2D(x.asF64, y.asF64) }

  var sqrLen: F64 { x.asF64.sqr + y.asF64.sqr }

  // Swizzles.
  var yx: Self { return Self(y, x) }
}


public protocol Vec3: Vec {
  init(_ x: Scalar, _ y: Scalar, _ z: Scalar)
  var x: Scalar { get set }
  var y: Scalar { get set }
  var z: Scalar { get set }
}

public extension Vec3 {
  init(scalar: Scalar) { self.init(scalar, scalar, scalar) }

  static var one: Self { return Self(1, 1, 1) }
  static var unitX: Self { Self(1, 0, 0) }
  static var unitY: Self { Self(0, 1, 0) }
  static var unitZ: Self { Self(0, 0, 1) }

  var vf: V3F { V3F(x.asF32, y.asF32, z.asF32) }
  var vd: V3D { V3D(x.asF64, y.asF64, z.asF64) }

  var sqrLen: F64 { x.asF64.sqr + y.asF64.sqr + z.asF64.sqr }

  // Swizzles.
  var xy: V2Type { return V2Type(x, y) }
  var xz: V2Type { return V2Type(x, z) }

  var yx: V2Type { return V2Type(y, x) }
  var yz: V2Type { return V2Type(y, z) }

  var zx: V2Type { return V2Type(z, x) }
  var zy: V2Type { return V2Type(z, y) }
}


public protocol Vec4: Vec {
  init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar)
  var x: Scalar { get set }
  var y: Scalar { get set }
  var z: Scalar { get set }
  var w: Scalar { get set }
}

public extension Vec4 {
  init(scalar: Scalar) { self.init(scalar, scalar, scalar, scalar) }

  static var one: Self { return Self(1, 1, 1, 1) }
  static var unitX: Self { Self(1, 0, 0, 0) }
  static var unitY: Self { Self(0, 1, 0, 0) }
  static var unitZ: Self { Self(0, 0, 1, 0) }
  static var unitW: Self { Self(0, 0, 0, 1) }

  var vf: V4F { V4F(x.asF32, y.asF32, z.asF32, w.asF32) }
  var vd: V4D { V4D(x.asF64, y.asF64, z.asF64, w.asF64) }

  var sqrLen: F64 { x.asF64.sqr + y.asF64.sqr + z.asF64.sqr + w.asF64.sqr }
}
