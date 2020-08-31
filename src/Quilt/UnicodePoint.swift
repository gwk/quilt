// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


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
