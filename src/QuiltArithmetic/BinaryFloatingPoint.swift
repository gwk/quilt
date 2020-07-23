// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


extension BinaryFloatingPoint {

  public var sqr: Self { return self * self }
  public var sqrt: Self { return self.squareRoot() }
  public var ceil: Self { return Darwin.ceil(self) }
  public var floor: Self { return Darwin.floor(self) }
  public var rnd: Self { return self.rounded() }

  public var asF32: F32 { return F32(self) }
  public var asF64: F64 { return F64(self) }
  public var asInt: Int { return Int(self) }
  public var asRoundedInt: Int { return Int(self.rounded()) }

  public var signedUnit: Self { return self < 0 ? -1 : 1 }

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
    return U8(self.clampToUnit * 255)
  }

  public var clampToSignedUnitAndConvertToU8: U8 {
    return (self*0.5 + 0.5).clampToUnitAndConvertToU8
  }
}
