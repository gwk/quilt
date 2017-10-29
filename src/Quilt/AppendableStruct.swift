// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


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
