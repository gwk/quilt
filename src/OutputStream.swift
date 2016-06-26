// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


extension OutputStream {

  public mutating func write(_ items: [Any], sep: String, end: String) {
    var first = true
    for item in items {
      if first {
        first = false
      } else {
        self.write(sep)
      }
      self.write(String(item))
    }
    self.write(end)
  }
}
