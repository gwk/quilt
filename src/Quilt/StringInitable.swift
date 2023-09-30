// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


final class StringConversionError: Error {
  let exp: Any.Type
  let string: String

  init(exp: Any.Type, string: String) {
    self.exp = exp
    self.string = string
  }
}

public protocol StringInitable {
  init(string: String) throws
}

extension String: StringInitable {
  public init(string: String) { self = string }
}

extension Int: StringInitable {
  public init(string: String) throws {
    if let i = Int(string) {
      self = i
    } else { throw StringConversionError(exp: Int.self, string: string) }
  }
}

extension UInt: StringInitable {
  public init(string: String) throws {
    if let u = UInt(string) {
      self = u
    } else { throw StringConversionError(exp: UInt.self, string: string) }
  }
}

extension Float: StringInitable {
  public init(string: String) throws {
    if let f = Float(string) {
      self = f
    } else { throw StringConversionError(exp: Float.self, string: string) }
  }
}

extension Double: StringInitable {
  public init(string: String) throws {
    if let d = Double(string) {
      self = d
    } else { throw StringConversionError(exp: Double.self, string: string) }
  }
}

extension Bool: StringInitable {

  public init?(_ text: String) {
    switch text {
    case "false": self = false
    case "true":  self = true
    case "False": self = false
    case "True":  self = true
    case "FALSE": self = false
    case "TRUE":  self = true
    default: return nil
    }
  }

  public init(string: String) throws {
    if let b = Bool(string) {
      self = b
    } else { throw StringConversionError(exp: Bool.self, string: string) }
  }
}
