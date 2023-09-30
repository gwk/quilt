// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public struct Err<T>: Error, CustomStringConvertible {
  let val: T

  init(_ val: T) {
    self.val = val
  }

  public var description: String { "Err(\(val))" }
}
