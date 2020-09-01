// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


import Foundation
import simd
import QuiltArithmetic


public typealias V2S = SIMD2<F32>
public typealias V2D = SIMD2<F64>
public typealias V2I = SIMD2<Int>
public typealias V2U8 = SIMD2<U8>

public typealias V3S = SIMD3<F32>
public typealias V3D = SIMD3<F64>
public typealias V3I = SIMD3<Int>
public typealias V3U8 = SIMD3<U8>

public typealias V4S = SIMD4<F32>
public typealias V4D = SIMD4<F64>
public typealias V4I = SIMD4<Int>
public typealias V4U8 = SIMD4<U8>


// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin
import QuiltArithmetic


public protocol Vec: Equatable, CustomStringConvertible {
  associatedtype Scalar: ArithmeticProtocol
  associatedtype VSType: FloatVec where VSType.Scalar == F32
  associatedtype VDType: FloatVec where VDType.Scalar == F64

  init()
  init(_ v: VSType)
  init(_ v: VDType)

  static var zero: Self { get }

  static var scalarCount: Int { get }

  subscript(index: Int) -> Scalar { get set }

  var x: Scalar { get }
  var y: Scalar { get }
  var vs: VSType { get }
  var vd: VDType { get }
  var sqrLen: F64 { get }

  func dot(_ b: Self) -> F64
}


extension Vec {

  public var len: F64 { sqrLen.sqrt }
  public var heading: F64 { atan2(y.asF64, x.asF64) }

  public func angle(_ b: Self) -> F64 { acos(self.dot(b) / (self.len * b.len)) }
}


public protocol Vec2: Vec {
  init(_ x: Scalar, _ y: Scalar)
  var x: Scalar { get set }
  var y: Scalar { get set }
}


public protocol Vec3: Vec {
  init(_ x: Scalar, _ y: Scalar, _ z: Scalar)
  var x: Scalar { get set }
  var y: Scalar { get set }
  var z: Scalar { get set }
}


public protocol Vec4: Vec {
  init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar)
  var x: Scalar { get set }
  var y: Scalar { get set }
  var z: Scalar { get set }
  var w: Scalar { get set }
}
