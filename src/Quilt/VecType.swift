// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


public protocol VecType: Equatable, CustomStringConvertible {
  associatedtype Scalar: ArithmeticProtocol
  associatedtype VSType: FloatVecType where VSType.Scalar == F32
  associatedtype VDType: FloatVecType where VDType.Scalar == F64

  init(_ v: VSType)
  init(_ v: VDType)

  static var scalarCount: Int { get }

  var x: Scalar { get }
  var y: Scalar { get }
  var vs: VSType { get }
  var vd: VDType { get }
  var sqrLen: F64 { get }

  func dot(_ b: Self) -> F64
}


extension VecType {

  public var len: F64 { return sqrLen.sqrt }
  public var heading: F64 { return atan2(y.asF64, x.asF64) }

  public func angle(_ b: Self) -> F64 { return acos(self.dot(b) / (self.len * b.len)) }
}


public protocol VecType2: VecType {
  init(_ x: Scalar, _ y: Scalar)
  var x: Scalar { get }
  var y: Scalar { get }
}


public protocol VecType3: VecType {
  init(_ x: Scalar, _ y: Scalar, _ z: Scalar)
  var x: Scalar { get }
  var y: Scalar { get }
  var z: Scalar { get }
}


public protocol VecType4: VecType {
  init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar)
  var x: Scalar { get }
  var y: Scalar { get }
  var z: Scalar { get }
  var w: Scalar { get }
}
