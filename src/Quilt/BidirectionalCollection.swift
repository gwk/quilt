// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


extension BidirectionalCollection where Iterator.Element : Equatable {

  public func index(ofLast el: Element) -> Index? {
    guard let i = reversed().index(of: el) else { return nil }
    return index(before: i.base)
  }
}
