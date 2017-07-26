// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


public struct Adj {
  public var a, b: Int

  public init(_ a: Int, _ b: Int) {
    if (a < b) {
      self.a = a
      self.b = b
    } else {
      self.a = b
      self.b = a
    }
  }
}
