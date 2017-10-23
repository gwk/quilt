// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


public let digitChars = [Character]("0123456789abcdef")

extension Int {

  public func repr(radix: Int = 10, pad: Character = " ", width: Int = 0) -> String {
    if self == 0 {
      let count = Swift.max(0, width - 1)
      return String(char: pad, count: count) + "0"
    }
    var a = [Character]()
    let neg = (self < 0)
    var i = neg ? -self : self
    while i != 0 {
      let d = i % radix
      a.append(digitChars[d])
      i /= radix
    }
    var pad_len = width - (a.count + (neg ? 1 : 0))
    if neg {
      a.append("-")
    }
    while pad_len > 0 {
      a.append(pad)
      pad_len -= 1
    }
    return String(Array(a.reversed()))
  }

  public func dec(width: Int) -> String { return self.repr(radix: 10, width: width) }

  public func hex(width: Int) -> String { return self.repr(radix: 16, width: width) }

  public func dec0(width: Int) -> String { return self.repr(radix: 10, pad: "0", width: width) }

  public func hex0(width: Int) -> String { return self.repr(radix: 16, pad: "0", width: width) }
}
