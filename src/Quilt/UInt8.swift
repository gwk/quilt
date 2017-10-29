// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


extension UInt8: ExpressibleByUnicodeScalarLiteral {
  public typealias UnicodeScalarLiteralType = Unicode.Scalar

  public init(unicodeScalarLiteral value: Unicode.Scalar) {
    self = UInt8(value.value)
  }
}
