// © 2019 George King. Permission to use this file is granted in license-quilt.txt.

import QuiltArithmetic


public protocol IntVec: Vec where Scalar: SignedArithmeticInt {

  static func +(l: Self, r: Self) -> Self
  static func -(l: Self, r: Self) -> Self
  static func *(l: Self, r: Scalar) -> Self
  static func /(l: Self, r: Scalar) -> Self
}


extension IntVec {

  public func dist(_ b: Self) -> F64 { (b - self).len }

  public func mid(_ b: Self) -> Self { (self + b) / 2 }
}


public protocol IntVec2: IntVec, Vec2 {}


public protocol IntVec3: IntVec, Vec3 {}


public protocol IntVec4: IntVec, Vec4 {}
