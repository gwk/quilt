// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


public protocol ArithmeticProtocol: Hashable, Numeric, Strideable {

  init<Source>(_ value: Source) where Source : BinaryInteger
  init<Source>(_ value: Source) where Source : BinaryFloatingPoint
  init?<Source>(exactly value: Source) where Source : BinaryInteger
  init?<Source>(exactly value: Source) where Source : BinaryFloatingPoint

  var asF32: F32 { get }
  var asF64: F64 { get }
  var asInt: Int { get }

  static func /(l: Self, r: Self) -> Self
}


extension ArithmeticProtocol {

  public func clamp(min: Self, max: Self) -> Self {
    if self < min { return min }
    if self > max { return max }
    return self
  }
}


extension Sequence where Element: ArithmeticProtocol {

  public func sum() -> Element {
    reduce(0) { (accum: Element, item: Element) in accum + item }
  }

  public func prod() -> Element {
    reduce(1) { (accum: Element, item: Element) in accum * item }
  }
}

