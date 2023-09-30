// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


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
