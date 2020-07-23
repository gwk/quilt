// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


public protocol ArithmeticProtocol: Hashable, Numeric, Strideable {

  init<Source>(_ value: Source) where Source : BinaryInteger
  init<Source>(_ value: Source) where Source : BinaryFloatingPoint
  init?<Source>(exactly value: Source) where Source : BinaryInteger
  init?<Source>(exactly value: Source) where Source : BinaryFloatingPoint

  var asF32: F32 { get }
  var asF64: F64 { get }
  var asInt: Int { get }

  static func +(l: Self, r: Self) -> Self
  static func -(l: Self, r: Self) -> Self
  static func *(l: Self, r: Self) -> Self
  static func /(l: Self, r: Self) -> Self
  static func <(l: Self, r: Self) -> Bool
  static func >(l: Self, r: Self) -> Bool
  static func <=(l: Self, r: Self) -> Bool
  static func >=(l: Self, r: Self) -> Bool
}


extension ArithmeticProtocol {

  public func clamp(min: Self, max: Self) -> Self {
    if self < min { return min }
    if self > max { return max }
    return self
  }
}


public func sign<T: ArithmeticProtocol>(_ b: Bool) -> T {
  return b ? 1 : -1
}


extension Sequence where Element: ArithmeticProtocol {

  public func sum() -> Element {
    return reduce(0) { (accum: Element, item: Element) in return accum + item }
  }

  public func prod() -> Element {
    return reduce(1) { (accum: Element, item: Element) in return accum * item }
  }
}
