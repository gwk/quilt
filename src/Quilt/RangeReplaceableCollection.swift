// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


extension RangeReplaceableCollection where Element: Equatable {

  public mutating func prepend(_ el: Element) {
    insert(el, at: startIndex)
  }

  public mutating func replace<S: Sequence, C: Collection>(prefix: S, with replacement: C) -> Bool where S.Element == Element, C.Element == Element {
    if let idx = indexAfter(prefix: prefix) {
      replaceSubrange(startIndex..<idx, with: replacement)
      return true
    }
    return false
  }

  public mutating func truncate(_ index: Index) {
    removeSubrange(index..<endIndex)
  }
}
