// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public protocol JsonInitable {
  init(json: JsonType) throws
}

extension JsonType {
  public func conv<T: JsonInitable>() throws -> T { return try T(json: self) }
}

extension Int: JsonInitable {
  public init(json: JsonType) throws {
    if let n = json as? NSNumber {
      if let i = n as? Int {
        self = i
      } else { throw Json.Err.conversion(exp: Int.self, json: json) }
    } else if let s = json as? NSString {
      if let n = Int(s as String) {
        self = n
      } else { throw Json.Err.conversion(exp: Int.self, json: json) }
    } else { throw Json.Err.unexpectedType(exp: Int.self, json: json) }
  }
}

extension UInt: JsonInitable {
  public init(json: JsonType) throws {
    if let n = json as? NSNumber {
      if let u = n as? UInt {
        self = u
      } else { throw Json.Err.conversion(exp: UInt.self, json: json) }
    } else if let s = json as? NSString {
      if let n = UInt(s as String) {
        self = n
      } else { throw Json.Err.conversion(exp: UInt.self, json: json) }
    } else { throw Json.Err.unexpectedType(exp: UInt.self, json: json) }
  }
}

extension U8: JsonInitable {
  public init(json: JsonType) throws {
    if let n = json as? NSNumber {
      if let u = n as? U8 {
        self = u
      } else { throw Json.Err.conversion(exp: U8.self, json: json) }
    } else if let s = json as? NSString {
      if let n = UInt(s as String) {
        if n > UInt(U8.max) { throw Json.Err.conversion(exp: U8.self, json: json) }
        self = U8(n)
      } else { throw Json.Err.conversion(exp: U8.self, json: json) }
    } else { throw Json.Err.unexpectedType(exp: U8.self, json: json) }
  }
}

extension Float: JsonInitable {
  public init(json: JsonType) throws {
    if let n = json as? NSNumber {
      if let f = n as? Float {
        self = f
      } else { throw Json.Err.conversion(exp: Float.self, json: json) }
    } else if let s = json as? NSString {
      if let n = Float(s as String) {
        self = n
      } else { throw Json.Err.conversion(exp: Float.self, json: json) }
    } else { throw Json.Err.unexpectedType(exp: Float.self, json: json) }
  }
}

extension Double: JsonInitable {
  public init(json: JsonType) throws {
    if let n = json as? NSNumber {
      if let d = n as? Double {
        self = d
      } else { throw Json.Err.conversion(exp: Double.self, json: json) }
    } else if let s = json as? NSString {
      if let n = Double(s as String) {
        self = n
      } else { throw Json.Err.conversion(exp: Double.self, json: json) }
    } else { throw Json.Err.unexpectedType(exp: Double.self, json: json) }
  }
}

extension Bool: JsonInitable {
  public init(json: JsonType) throws {
    if let n = json as? NSNumber {
      if let b = n as? Bool {
        self = b
      } else { throw Json.Err.conversion(exp: Bool.self, json: json) }
    } else if let s = json as? NSString {
      guard let b = Bool(s as String) else { throw Json.Err.conversion(exp: Bool.self, json: json) }
      self = b
    } else { throw Json.Err.unexpectedType(exp: Bool.self, json: json) }
  }
}

extension String: JsonInitable {
  public init(json: JsonType) throws {
    if let s = json as? String {
      self = s
    } else { throw Json.Err.unexpectedType(exp: String.self, json: json) }
  }
}
