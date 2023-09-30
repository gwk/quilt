// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import QuiltArithmetic


public protocol FloatVec: Vec where Scalar: ArithmeticFloat {

  static func +(l: Self, r: Self) -> Self
  static func -(l: Self, r: Self) -> Self
  static func *(l: Self, r: Scalar) -> Self
  static func /(l: Self, r: Scalar) -> Self
  var clampToUnit: Self { get }
}


extension FloatVec {

  public var norm: Self { self / Scalar(self.len) }

  public func dist(_ b: Self) -> F64 { (b - self).len }

  public func lerp(_ b: Self, _ t: F64) -> Self {
    let ad: VDType = self.vd
    let bd: VDType = b.vd
    return Self.init(ad * (1-t) + bd*t)
  }

  public func mid(_ b: Self) -> Self { (self + b) / 2 }
}



public protocol FloatVec2: FloatVec, Vec2 {}



public protocol FloatVec3: FloatVec, Vec3 {}

extension FloatVec3 {

  public func cross(_ b: Self) -> Self {
    Self(
      y * b.z - z * b.y,
      z * b.x - x * b.z,
      x * b.y - y * b.x)
  }

  public func cleanEulerAngles(forIndex index: Int) -> Self {
    var e = self
    e.formCleanEulerAngles(forIndex: index)
    return e
  }

  public mutating func formCleanEulerAngles(forIndex index: Int) {
    // TODO: not sure if normalizing to within +-2pi is necessary, or if SceneKit does this for us already.
    formRemainderTwoPi() // Each angle is now in +-2pi.
    let s = self[index]
    if s >= -.pi/2 && s <= .pi/2 { return }
    // The order of mutations to the axes here does not matter, but SceneKit applies euler angles in zyx order, so we do to.
    z += (z <= 0 ? .pi : -.pi)
    y *= -1 // The crucial trick is to reverse any existing rotation of the Y axis, because the z axis was just flipped.
    y += (y <= 0 ? .pi : -.pi)
    x += (x <= 0 ? .pi : -.pi) // Since the z and the y both flip before x, x is "reversed twice" and so stays positive.
  }

  public mutating func formRemainderTwoPi() {
    x.formRemainder(dividingBy: .pi*2)
    y.formRemainder(dividingBy: .pi*2)
    z.formRemainder(dividingBy: .pi*2)
  }
}



public protocol FloatVec4: FloatVec, Vec4 {}



extension Sequence where Element: FloatVec {

  public func mean() -> Element.VDType {
    var sum:Element.VDType = .zero
    var count = 0
    for el in self {
      sum = sum + el.vd
      count += 1
    }
    return sum / count.asF64
  }
}
