// © 2016 George King. Permission to use this file is granted in license.txt.


public struct Counter<Key: Hashable> {
  public var dict: [Key: Int] = [:]

  public init(dict: [Key: Int] = [:]) {
    self.dict = dict
  }
  
  public subscript(key: Key) -> Int { return dict[key].or(0) }

  public mutating func increment(_ key: Key) -> Int {
    let c = self[key]
    dict[key] = c + 1
    return c
  }
}
