// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


extension UInt16 {

  public init(ascii: UnicodeScalar) {
    self = UInt16(UInt8(ascii: ascii))
  }
}
