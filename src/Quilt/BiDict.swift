// © 2020 George King. Permission to use this file is granted in license-quilt.txt.


public class BiDict<Key: Hashable, Value: Hashable>: ExpressibleByDictionaryLiteral {

  public private(set) var fwd: Dictionary<Key, Value> = [:]
  public private(set) var rev: Dictionary<Value, Key> = [:]

  public init() {}


  public required init(dictionaryLiteral elements: (Key, Value)...) {
    fwd = Dictionary(uniqueKeysWithValues: elements)
    rev = Dictionary(uniqueKeysWithValues: elements.map { ($1, $0) })
  }


  public subscript(key: Key) -> Value? {
    get { fwd[key] }
    set {
      if let oldValue = fwd[key] {
        rev.removeValue(forKey: oldValue)
      }
      fwd[key] = newValue
      if let newValue = newValue {
        rev[newValue] = key
      }
    }
  }
}
