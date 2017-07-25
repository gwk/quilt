// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import Cocoa


public let unicodeArrowUp    = UnicodeScalar(0xF700)
public let unicodeArrowDown  = UnicodeScalar(0xF701)
public let unicodeArrowLeft  = UnicodeScalar(0xF702)
public let unicodeArrowRight = UnicodeScalar(0xF703)


extension NSEvent {

  public var unicodeScalar: UnicodeScalar {
    let scalars = charactersIgnoringModifiers!.unicodeScalars
    assert(scalars.count == 1)
    return scalars.first!
  }

}
