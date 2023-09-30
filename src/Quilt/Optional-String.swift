// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension Optional where Wrapped == String {

  public var repr: String {
    if let val = self {
      return val.repr
    } else {
      return "nil"
    }
  }
}
