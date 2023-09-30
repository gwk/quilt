// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public protocol AppendableStruct {
  associatedtype Element
  mutating func append(_ element: Element)
}


extension Array: AppendableStruct {}
extension String: AppendableStruct {}


extension Dictionary where Value: AppendableStruct & DefaultInitializable {

  public mutating func appendToValue(_ key: Key, _ el: Value.Element) {
    if self[key] == nil {
      self[key] = Value()
    }
    self[key]!.append(el)
  }
}
