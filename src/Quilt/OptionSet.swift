// © 2016 George King. Permission to use this file is granted in license-quilt.txt.


extension OptionSet {

  public mutating func toggle(_ el: Element) {
    if contains(el) {
      remove(el)
    } else {
      insert(el)
    }
  }

}
