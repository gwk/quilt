// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


extension TextOutputStream {

  public mutating func write(_ items: [Any], sep: String, end: String) {
    var first = true
    for item in items {
      if first {
        first = false
      } else {
        self.write(sep)
      }
      self.write(String(describing: item))
    }
    self.write(end)
  }

  mutating public func writeL(_ string: String) {
    write(string)
    write("\n")
  }

  mutating public func writeLines(_ strings: String...) {
    for s in strings {
      writeL(s)
    }
  }
}
