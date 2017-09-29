// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


extension Dictionary {

  init<S: Sequence>(elements: S) where S.Iterator.Element == Iterator.Element {
    self = [:]
    for (k, v) in elements {
      self[k] = v
    }
  }

  public func contains(key: Key) -> Bool {
    return self[key] != nil
  }

  public mutating func insertNew(_ key: Key, value: Value) {
    assert(!contains(key: key), "insertNew: key already inserted: \(key); value: \(value)")
    self[key] = value
  }

  public mutating func insertNewOrElse(_ key: Key, value: Value, body: ()->()) {
    if contains(key: key) {
      body()
    } else {
      self[key] = value
    }
  }

  public mutating func insertNewOrElse(_ key: Key, value: Value, body: () throws -> Void) rethrows {
    if contains(key: key) {
      try body()
    } else {
      self[key] = value
    }
  }


  public mutating func updateExisting(_ key: Key, value: Value) {
    assert(contains(key: key), "updateExisting: key not yet inserted: \(key); value: \(value)")
    self[key] = value
  }


  public mutating func getOrInsert(_ key: Key, dflt: () -> Value) -> Value {
    if let v = self[key] {
      return v
    } else {
      let v = dflt()
      self[key] = v
      return v
    }
  }
}


extension Dictionary where Value: DefaultInitializable {

  public mutating func getOrDefault(_ key: Key) -> Value {
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
    return pairsSortedByKey.map() { $0.value }
  }
}
