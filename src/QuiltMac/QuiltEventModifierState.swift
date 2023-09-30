// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit


public enum QuiltEventModifierState: UInt {

  // The bits for the key flags we care about are as follows:
  // shift:   1 << 17
  // control: 1 << 18
  // option:  1 << 19
  // command: 1 << 20

  case none             = 0b0000
  case shift            = 0b0001
  case ctrl             = 0b0010
  case ctrlShift        = 0b0011
  case opt              = 0b0100
  case optShift         = 0b0101
  case ctrlOpt          = 0b0110
  case ctrlOptShift     = 0b0111
  case cmd              = 0b1000
  case cmdShift         = 0b1001
  case cmdCtrl          = 0b1010
  case cmdCtrlShift     = 0b1011
  case cmdOpt           = 0b1100
  case cmdOptShift      = 0b1101
  case cmdCtrlOpt       = 0b1110
  case cmdCtrlOptShift  = 0b1111


  public init(flags: NSEvent.ModifierFlags) {
    let bits = flags.rawValue >> 17 & 0b1111
    self.init(rawValue: bits)!
  }


  static var cmdBit: UInt { 0b1000 }
  static var ctrlBit: UInt { 0b0010 }
  static var optBit: UInt { 0b0100 }
  static var shiftBit: UInt { 0b0001 }

  public var pressingCmd: Bool {
    (rawValue & Self.cmdBit) != 0
  }

  public var pressingCtrl: Bool {
    (rawValue & Self.ctrlBit) != 0
  }

  public var pressingOpt: Bool {
    (rawValue & Self.optBit) != 0
  }

  public var pressingShift: Bool {
    (rawValue & Self.shiftBit) != 0
  }
}
