// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension Character {

  public var isDigit: Bool { "0123456789".contains(self) }

  public var asString: String { String(self) }

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
