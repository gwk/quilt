// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


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
