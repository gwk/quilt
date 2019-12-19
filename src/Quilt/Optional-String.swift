// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


extension Optional where Wrapped == String {

  public var repr: String {
    if let val = self {
      return val.repr
    } else {
      return "nil"
    }
  }
}
