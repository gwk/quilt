// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


extension BinaryFloatingPoint {

  public var sqr: Self { self * self }
  public var sqrt: Self { self.squareRoot() }
  public var ceil: Self { Darwin.ceil(self) }
  public var floor: Self { Darwin.floor(self) }
  public var rnd: Self { self.rounded() }

  public var asF32: F32 { F32(self) }
  public var asF64: F64 { F64(self) }
  public var asInt: Int { Int(self) }
  public var asRoundedInt: Int { Int(self.rounded()) }

  public var isZeroOrSubnormal: Bool { isZero || isSubnormal }

  public var signedUnit: Self { self < 0 ? -1 : 1 }

  public var clampToUnit: Self {
    if self <= 0 { return 0 }
    if self >= 1 { return 1 }
    return self
  }

  public var clampToSignedUnit: Self {
    if self <= -1 { return -1 }
    if self >= 1 { return 1 }
    return self
  }

  public var clampToUnitAndConvertToU8: U8 {
    U8(self.clampToUnit * 255)
  }

  public var clampToSignedUnitAndConvertToU8: U8 {
    (self*0.5 + 0.5).clampToUnitAndConvertToU8
  }

  public var degToRad: Self {
    self * .pi / 180
  }
}
