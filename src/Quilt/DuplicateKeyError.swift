// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


public struct DuplicateKeyError<K, V>: ErrorProtocol {
  public let key: K
  public let existing: V
  public let incoming: V
}
