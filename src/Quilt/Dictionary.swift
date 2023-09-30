// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


extension Dictionary {

  init<S: Sequence>(elements: S) where S.Element == Element {
    self = [:]
    for (k, v) in elements {
      self[k] = v
    }
  }

  public func contains(key: Key) -> Bool {
    self[key] != nil
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


  public mutating func getOrInsert(_ key: Key, dflt: Value) -> Value {
    if let v = self[key] {
      return v
    } else {
      self[key] = dflt
      return dflt
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
    self.sorted() {
      (a, b) in
      a.key < b.key
    }
  }

  public var valsSortedByKey: [Value] {
    pairsSortedByKey.map() { $0.value }
  }
}
