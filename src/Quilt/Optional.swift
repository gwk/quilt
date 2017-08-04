// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


extension Optional {

  public func and<T>(_ body: (Wrapped) throws -> T) rethrows -> T? {
    if let val = self {
      return try body(val)
    } else {
      return nil
    }
  }

  public func and<T>(_ body: (Wrapped) throws -> T, or alt: @autoclosure () throws -> T) rethrows -> T {
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
