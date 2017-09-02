// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


public struct Err<T>: Error {
  let val: T

  init(_ val: T) {
    self.val = val
  }
}
