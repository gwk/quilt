// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


public typealias Uns = UInt

public typealias I8  = Int8
public typealias I16 = Int16
public typealias I32 = Int32
public typealias I64 = Int64

public typealias U8  = UInt8
public typealias U16 = UInt16
public typealias U32 = UInt32
public typealias U64 = UInt64


public protocol ArithmeticProtocol: ExpressibleByIntegerLiteral, Equatable, Comparable {
  static func +(l: Self, r: Self) -> Self
  static func -(l: Self, r: Self) -> Self
  static func *(l: Self, r: Self) -> Self
  static func /(l: Self, r: Self) -> Self
  static func %(l: Self, r: Self) -> Self
  static func <(l: Self, r: Self) -> Bool
  static func >(l: Self, r: Self) -> Bool
  static func <=(l: Self, r: Self) -> Bool
  static func >=(l: Self, r: Self) -> Bool
}

extension Int: ArithmeticProtocol {}
extension I8: ArithmeticProtocol {}
extension I16: ArithmeticProtocol {}
extension I32: ArithmeticProtocol {}
extension I64: ArithmeticProtocol {}

extension Uns: ArithmeticProtocol {}
extension U8: ArithmeticProtocol {}
extension U16: ArithmeticProtocol {}
extension U32: ArithmeticProtocol {}
extension U64: ArithmeticProtocol {}

public func clamp<T: ArithmeticProtocol>(_ a: T, min: T, max: T) -> T {
  if a < min { return min }
  if a > max { return max }
  return a
}

public func sign<T: ArithmeticProtocol>(_ b: Bool) -> T {
  return b ? 1 : -1
}

public func sign<T: ArithmeticProtocol>(_ x: T) -> T {
  if x < 0 { return -1 }
  if x > 0 { return 1 }
  return 0
}


extension Sequence where Iterator.Element: ArithmeticProtocol {

  public func sum() -> Iterator.Element {
    return reduce(0) { (accum: Iterator.Element, item: Iterator.Element) in return accum + item }
  }

  public func prod() -> Iterator.Element {
    return reduce(1) { (accum: Iterator.Element, item: Iterator.Element) in return accum * item }
  }
}

