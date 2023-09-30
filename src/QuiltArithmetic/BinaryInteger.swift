// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public let digitChars = [Character]("0123456789abcdef")


extension BinaryInteger {

  public var asF32: F32 { F32(self) }
  public var asF64: F64 { F64(self) }
  public var asInt: Int { Int(self) }


  public func repr(radix: Int = 10, pad: Character = " ", width: Int = 0) -> String {
    let radix_ = Self(radix)
    if self == 0 {
      let count = Swift.max(0, width - 1)
      return String(repeating: pad, count: count) + "0"
    }
    var a = [Character]()
    let isNeg = (self < 0)
    var i = self
    var d: Self = 0
    while i != 0 {
      (i, d) = i.quotientAndRemainder(dividingBy: radix_)
      a.append(digitChars[Int(d)])
    }
    if isNeg {
      a.append("-")
    }
    var pad_len = width - (a.count + (isNeg ? 1 : 0))
    while pad_len > 0 {
      a.append(pad)
      pad_len -= 1
    }
    return String(Array(a.reversed()))
  }

  public var sign: FloatingPointSign { self < 0 ? .minus : .plus }

  public var signedUnit: Self { self < 0 ? -1 : 1 }

  public func decimal(width: Int = 0) -> String { self.repr(radix: 10, width: width) }

  public func hex(width: Int = 0) -> String { self.repr(radix: 16, width: width) }

  public func decimal0(width: Int = 0) -> String { self.repr(radix: 10, pad: "0", width: width) }

  public func hex0(width: Int = 0) -> String { self.repr(radix: 16, pad: "0", width: width) }
}
