// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension UInt16 {

  public init(ascii: UnicodeScalar) {
    self = UInt16(UInt8(ascii: ascii))
  }
}
