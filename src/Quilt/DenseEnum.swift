// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public protocol DenseEnum: CaseIterable, Comparable {

  init?(rawValue: Int)

  var rawValue: Int { get }
}


extension DenseEnum {

  public static var count: Int { allCases.count }

  public static var range: CountableRange<Int> { 0..<count }

  public static var firstCase: Self? { count == 0 ? nil : Self(rawValue: 0) }

  public static func < (lhs: Self, rhs: Self) -> Bool {
    /// Default implementation of Comparable.
    return lhs.rawValue < rhs.rawValue
  }
}


public struct EnumSetU32<Element: DenseEnum>: ExpressibleByArrayLiteral {
  public var rawValue: UInt32

  public init() {
    self.rawValue = 0
  }

  public init(_ element: Element) {
    self.rawValue = 1 << UInt32(element.rawValue)
  }

  public init(arrayLiteral elements: Element...) {
    self.rawValue = elements.reduce(0) { $0 | 1 << UInt32($1.rawValue) }
  }

  public mutating func add(_ element: Element) {
    rawValue |= UInt32(1 << element.rawValue)
  }
}
