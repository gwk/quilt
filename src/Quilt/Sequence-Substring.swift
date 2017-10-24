// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


extension Sequence where Iterator.Element == Substring {

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