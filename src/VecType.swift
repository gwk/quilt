// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


public protocol VecType: Equatable, CustomStringConvertible {
  associatedtype Scalar: ArithmeticProtocol
  associatedtype FloatType: ArithmeticFloat
  associatedtype VSType
  associatedtype VDType
  
  var x: Scalar { get }
  var y: Scalar { get }
  var vs: VSType { get }
  var vd: VDType { get }
  var sqrLen: FloatType { get }
  var len: FloatType { get }

  func +(l: Self, r: Self) -> Self
  func -(l: Self, r: Self) -> Self
  func *(l: Self, r: Scalar) -> Self
  func /(l: Self, r: Scalar) -> Self
}

extension VecType {
  public var len: FloatType { return sqrLen.sqrt }
  public func dist(_ b: Self) -> FloatType { return (b - self).len }
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

public protocol FloatVecType: VecType {
  var norm: Self { get }
  var clampToUnit: Self { get }
  func dist(_ b: Self) -> Scalar
  func dot(_ b: Self) -> Scalar
  func angle(_ b: Self) -> Scalar
}

public protocol IntVecType: VecType {

}

