// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension Optional {

  public func map<T>(_ body: (Wrapped) throws -> T, or alt: @autoclosure () throws -> T) rethrows -> T {
    if let val = self {
      return try body(val)
    } else {
      return try alt()
    }
  }

  public var optDesc: String {
    if let val = self {
      return String(reflecting: val)
    }
    return "nil"
  }
}


extension Optional: Comparable where Wrapped: Comparable {

  public static func < (lhs: Self, rhs: Self) -> Bool {
    // Define nil to be less than any Wrapped value.
    if let lhs = lhs {
      if let rhs = rhs {
        return lhs < rhs
      } else { // Only RHS is nil.
        return false
      }
    } else { // LHS is nil.
      return rhs != nil
    }
  }
}
