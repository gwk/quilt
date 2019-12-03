// © 2019 George King. Permission to use this file is granted in license-quilt.txt.


public protocol FloatVecType: VecType where Scalar: ArithmeticFloat {

  static func +(l: Self, r: Self) -> Self
  static func -(l: Self, r: Self) -> Self
  static func *(l: Self, r: Scalar) -> Self
  static func /(l: Self, r: Scalar) -> Self
  var clampToUnit: Self { get }
}


extension FloatVecType {

  public var norm: Self { return self / Scalar(self.len) }

  public func dist(_ b: Self) -> F64 { return (b - self).len }

  public func lerp(_ b: Self, _ t: F64) -> Self {
    let ad: VDType = self.vd
    let bd: VDType = b.vd
    return Self.init(ad * (1-t) + bd*t)
  }

  public func mid(_ b: Self) -> Self { return (self + b) / 2 }
}
