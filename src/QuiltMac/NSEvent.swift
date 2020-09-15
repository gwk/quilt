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


  public func location(in view: NSView) -> CGPoint {
    return view.convert(locationInWindow, from: nil) // Nil indicates that convert should use window coordinates.
  }


  public var modifiersAndKey: (NSEvent.ModifierFlags, String) {
    (modifierFlags.intersection(.deviceIndependentFlagsMask), charactersIgnoringModifiers ?? "")
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
