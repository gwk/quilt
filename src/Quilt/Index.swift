// © 2014 George King. Permission to use this file is granted in license-quilt.txt.


// TODO: rename.
public class Index<T: Hashable> {
  public var vals: [T] = []
  public var indexes: [T:Int] = [:]

  public init(_ vals: [T]) {
    self.vals = vals
    self.indexes = vals.enumerated().mapToDict { ($0.element, $0.offset) }
  }

  public var count: Int {
    assert(vals.count == indexes.count)
    return vals.count
  }

  public func val(_ i: Int) -> T { vals[i] }

  public func index(_ val: T) -> Int? { indexes[val] }

  public func reg(_ val: T) -> Int {
    let oi = indexes[val]
    if let i = oi {
      return i
    } else {
        let i = count
      vals.append(val)
      indexes[val] = i
      return i
    }
  }
}

