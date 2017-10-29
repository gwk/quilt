// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


public func fail<T>(label: String = "error", _ message: T) -> Never {
  if !label.isEmpty { errZ("\(label): ") }
  errL(message)
  exit(1)
}

public func check<T>(_ condition: Bool, label: String = "error", _ messageItem: @autoclosure ()->T) {
  if !condition {
    fail(label: label, messageItem())
  }
}

public func guarded<R>(label: String = "error", _ fn: () throws -> R) -> R {
  do {
    return try fn()
  } catch let e {
    fail(label: label, e)
  }
}
