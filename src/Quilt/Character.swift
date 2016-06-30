// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


extension Character {

  public var isDigit: Bool { return "0123456789".contains(self) }

  // unicode.
  
  public var codes: String.UnicodeScalarView { return String(self).unicodeScalars }
  
  public var code: UnicodeScalar {
    for c in codes { return c }
    return UnicodeScalar(0) // never reached.
  }
}
