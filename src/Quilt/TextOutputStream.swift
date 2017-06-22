// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


extension TextOutputStream {

  public mutating func write<T>(_ any: T) {
    // `write(_ string: String)` is the core method of this protocol.
    // We overload it to support any type, using the standard description.
    // We could further overload to prefer TextOutputStreamable over generic description.
    // However this makes the relationship with TextOutputStreamable rather loopy, and the type semantics become less clear.
    String(describing: any).write(to: &self)
  }

  public mutating func write<S: Sequence>(items: S, sep: String, end: String) {
    // S is strongly typed, as opposed to a sequence of dynamic Any objects.
    var first = true
    for item in items {
      if first {
        first = false
      } else {
        self.write(sep)
      }
      self.write(item)
    }
    self.write(end)
  }

  public mutating func write(head: Any, tail: [Any], sep: String, end: String) {
    // Dynamically typed Any for convenience methods below.
    self.write(head)
    for item in tail {
      self.write(sep)
      self.write(item)
    }
    self.write(end)
  }

  public mutating func writeZ(_ head: Any, _ tail: Any...) {
    write(head: head, tail: tail, sep: "", end: "")
  }

  public mutating func writeL(_ head: Any, _ tail: Any..., sep: String = "") {
    write(head: head, tail: tail, sep: sep, end: "\n")
  }

  public mutating func writeSL(_ head: Any, _ tail: Any...) {
    write(head: head, tail: tail, sep: " ", end: "\n")
  }

  public mutating func writeLL(_ head: Any, _ tail: Any...) {
    write(head: head, tail: tail, sep: "\n", end: "\n")
  }
}
