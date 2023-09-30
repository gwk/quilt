// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public protocol UnicodePoint {
  var unicodeScalar: UnicodeScalar? { get }
}


extension UnicodeScalar: UnicodePoint {
  public var unicodeScalar: UnicodeScalar? { self }
}

extension UInt8: UnicodePoint {
  public var unicodeScalar: UnicodeScalar? { self < 0x80 ? UnicodeScalar(self) : nil }
}

extension UInt16: UnicodePoint {
  public var unicodeScalar: UnicodeScalar? { UnicodeScalar(self) }
}

extension UInt32: UnicodePoint {
  public var unicodeScalar: UnicodeScalar? { UnicodeScalar(self) }
}

extension Int: UnicodePoint {
  public var unicodeScalar: UnicodeScalar? { UnicodeScalar(self) }
}
