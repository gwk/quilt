// © 2019 George King. Permission to use this file is granted in license-quilt.txt.


extension Encoder {

  public func encode(string: String) throws {
    var c = self.singleValueContainer()
    try c.encode(string)
  }


  public func encodeDescription<T>(_ obj:T) throws {
    var c = self.singleValueContainer()
    try c.encode(String(describing: obj))
  }
}
