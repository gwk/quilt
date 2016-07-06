// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


extension Dictionary {
  
  @warn_unused_result
  public func contains(key: Key) -> Bool {
    return self[key] != nil
  }

  public mutating func insertNew(_ key: Key, value: Value) {
    assert(!contains(key: key), "insertNew: key already inserted: \(key); value: \(value)")
    self[key] = value
  }

  public mutating func updateExisting(_ key: Key, value: Value) {
    assert(contains(key: key), "updateExisting: key not yet inserted: \(key); value: \(value)")
    self[key] = value
  }

  @warn_unused_result
  public func mapVals<V>(transform: @noescape (Value) throws -> V) rethrows -> [Key:V] {
    var d: [Key:V] = [:]
    for (k, v) in self {
      d[k] = try transform(v)
    }
    return d
  }

  @warn_unused_result
  public mutating func getDefault(_ key: Key, dflt: @noescape () -> Value) -> Value {
    if let v = self[key] {
      return v
    } else {
      let v = dflt()
      self[key] = v
      return v
    }
  }

  @warn_unused_result
  public mutating func getDefault(_ key: Key, dflt: Value) -> Value {
    if let v = self[key] {
      return v
    } else {
      let v = dflt
      self[key] = v
      return v
    }
  }
}


extension Dictionary where Value: DefaultInitializable {

  @warn_unused_result
  public mutating func getDefault(_ key: Key) -> Value {
    if let v = self[key] {
      return v
    } else {
      let v = Value()
      self[key] = v
      return v
    }
  }
}


extension Dictionary where Key: Comparable {

  public var pairsSortedByKey: [(key: Key, value: Value)] {
    return self.sorted() {
      (a, b) in
      return a.key < b.key
    }
  }

  public var valsSortedByKey: [Value] {
    return pairsSortedByKey.map() {
      (_, v) in return v
    }
  }
}


// TODO: remove in favor of ArrayDict public class?

public protocol AppendableValueType {
  associatedtype Element
  mutating func append(_ element: Element)
}


extension Array: AppendableValueType {}

extension Dictionary where Value: AppendableValueType, Value: DefaultInitializable {

  public mutating func appendToValue(_ key: Key, _ el: Value.Element) {
    var v: Value
    if let ov = removeValue(forKey: key) {
      v = ov
    } else {
      v = Value()
    }
    v.append(el)
    self[key] = v
  }
}
