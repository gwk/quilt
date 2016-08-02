// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


public struct DuplicateElError<T>: Error {
  public let el: T
}
