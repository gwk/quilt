// © 2019 George King. Permission to use this file is granted in license-quilt.txt.

import QuiltArithmetic


public protocol IntVecType: VecType where Scalar: SignedArithmeticInt {

  static func +(l: Self, r: Self) -> Self
  static func -(l: Self, r: Self) -> Self
  static func *(l: Self, r: Scalar) -> Self
  static func /(l: Self, r: Scalar) -> Self
}


extension IntVecType {

  public func dist(_ b: Self) -> F64 { return (b - self).len }

  public func mid(_ b: Self) -> Self { return (self + b) / 2 }
}
