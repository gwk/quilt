// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


public typealias Action = () -> ()
public typealias Predicate = () -> Bool


public let always: Predicate = { return true }
public let never: Predicate = { return false }


public func apply<T>(_ obj: T, body: (T)->()) -> T {
  body(obj)
  return obj
}


public func with<T>(_ obj: T, body: (T)->()) {
  body(obj)
}


public func vary<T: NSCopying>(_ obj: T, body: (T) -> ()) -> T {
  let c = obj.copy() as! T
  body(c)
  return c
}
