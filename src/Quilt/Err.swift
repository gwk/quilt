// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


public struct Err<T>: Error, CustomStringConvertible {
  let val: T

  init(_ val: T) {
    self.val = val
  }

  public var description: String { "Err(\(val))" }
}
