// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension OptionSet {

  public mutating func toggle(_ el: Element) {
    if contains(el) {
      remove(el)
    } else {
      insert(el)
    }
  }

}
