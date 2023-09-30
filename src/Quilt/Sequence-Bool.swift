// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension Sequence where Element == Bool {

  public func all() -> Bool {
    for e in self {
      if !e {
        return false
      }
    }
    return true
  }

  public func any() -> Bool {
    for e in self {
      if e {
        return true
      }
    }
    return false
  }
}
