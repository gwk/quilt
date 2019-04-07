// © 2019 George King. Permission to use this file is granted in license-quilt.txt.


extension Encoder {

  func encodeDescription<T>(_ obj:T) throws {
    var c = self.singleValueContainer()
    try c.encode(String(describing: obj))
  }
}
