// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


extension Character {

  public var isDigit: Bool { return "0123456789".contains(self) }

  public var asString: String { return String(self) }

  // unicode.

  public var singleUnicodeScalar: UnicodeScalar {
    assert(unicodeScalars.count == 1)
    for c in unicodeScalars { return c }
    fatalError() // never reached.
  }


  public init?<U: UnicodePoint>(unicodePoint: U) {
    guard let s = unicodePoint.unicodeScalar else { return nil }
    self.init(s)
  }
}
