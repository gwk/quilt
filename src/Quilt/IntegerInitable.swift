// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


public protocol IntegerInitable {
  init(_ v: Int)
  init(_ v: UInt)
  init(_ v: Int8)
  init(_ v: UInt8)
  init(_ v: Int16)
  init(_ v: UInt16)
  init(_ v: Int32)
  init(_ v: UInt32)
  init(_ v: Int64)
  init(_ v: UInt64)
}


extension Int: IntegerInitable {}
extension UInt: IntegerInitable {}
extension Int8: IntegerInitable {}
extension UInt8: IntegerInitable {}
extension Int16: IntegerInitable {}
extension UInt16: IntegerInitable {}
extension Int32: IntegerInitable {}
extension UInt32: IntegerInitable {}
extension Int64: IntegerInitable {}
extension UInt64: IntegerInitable {}
