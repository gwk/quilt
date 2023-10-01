// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit


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


  public var deltaPos: CGVector { return CGVector(deltaX, deltaY) }


  public var modifiersAndKey: (NSEvent.ModifierFlags, String) {
    (modifierFlags.intersection(.deviceIndependentFlagsMask), charactersIgnoringModifiers ?? "")
  }


  public var scrollingDeltaPrimary: CGFloat {
    // If shift is held down, then the main scroll wheel (normally the Y axis) becomes the X axis.
    // The secondary scroll wheel remains the X axis as well, so while shift is down we cannot disambiguate between them.
    // Furthermore, the trackpad behaves as normal.
    // The best we can do for now is sum the two when shift is held down.
    return modifierFlags.contains(.shift) ? (scrollingDeltaX + scrollingDeltaY) : scrollingDeltaY
  }
}


extension NSEvent.ModifierFlags: CustomStringConvertible {

  private static var flagDescs: [(NSEvent.ModifierFlags, String)] = [
    (.command, "⌘"),
    (.control, "⌃"),
    (.option, "⌥"),
    (.shift, "⇧"),
    (.capsLock, "⇪"),
    (.numericPad, "numpad"),
    (.help, "help"),
    (.function, "fn"),
  ]

  private static var knownFlags: NSEvent.ModifierFlags = [
    .command,
    .control,
    .option,
    .shift,
    .capsLock,
    .numericPad,
    .help,
    .function,
  ]

  public var description: String {
    if self.isEmpty { return "[]" }
    var result = ""
    for (flag, desc) in NSEvent.ModifierFlags.flagDescs {
      if self.contains(flag) {
        if !result.isEmpty && desc.count > 1 {
          result.append("-")
        }
        result.append(desc)
      }
    }
    let otherFlags = self.subtracting(NSEvent.ModifierFlags.knownFlags)
    if !otherFlags.isEmpty {
      result.append("+[0x\(otherFlags.rawValue.hex())]")
    }
    return result
  }
}
