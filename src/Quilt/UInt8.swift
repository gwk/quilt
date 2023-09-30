// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension UInt8: ExpressibleByUnicodeScalarLiteral {
  public typealias UnicodeScalarLiteralType = Unicode.Scalar

  public init(unicodeScalarLiteral value: Unicode.Scalar) {
    self = UInt8(value.value)
  }
}
