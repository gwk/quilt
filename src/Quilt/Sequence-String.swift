// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension Sequence where Iterator.Element == String {

  public func joined(separator: String) -> String {
    var s = ""
    for (i, substring) in enumerated() {
      if i > 0 { s.append(separator) }
      s.append(substring)
    }
    return s
  }

  public func joined(char: Character) -> String {
    var s = ""
    for (i, substring) in enumerated() {
      if i > 0 { s.append(char) }
      s.append(substring)
    }
    return s
  }
}
