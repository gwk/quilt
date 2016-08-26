// © 2015 George King. Permission to use this file is granted in license-quilt.txt.


extension Set {

  public init<S: Sequence>(sequences: S) where S.Iterator.Element: Sequence, S.Iterator.Element.Iterator.Element == Element {
    var set = Set()
    for sequence in sequences {
      set.formUnion(sequence)
    }
    self = set
  }

  public init<S: Sequence>(uniqueElements: S) throws where S.Iterator.Element == Iterator.Element {
    var set = Set()
    for el in uniqueElements {
      if set.contains(el) {
        throw DuplicateElError(el: el)
      }
      set.insert(el)
    }
    self = set
  }

  public func setByRemoving(_ member: Element) -> Set<Element> {
    var set = self
    set.remove(member)
    return set
  }

  public func setByReplacing(_ old: Element, with replacement: Element) -> Set<Element> {
    var set = self
    let removed = set.remove(old)
    assert(removed != nil)
    set.insert(replacement)
    return set
  }
}
