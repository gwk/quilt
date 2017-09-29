// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


public func check<T>(_ condition: Bool, label: String = "error", _ messageItem: @autoclosure ()->T) {
  if !condition {
    if !label.isEmpty { errZ("\(label): ") }
    errL(messageItem())
    exit(1)
  }
}

public func fail<T>(label: String = "error", _ messageItem: T) -> Never {
  if !label.isEmpty { errZ("\(label): ") }
  errL(messageItem)
  exit(1)
}

public func guarded<R>(label: String = "error", _ fn: () throws -> R) -> R {
  do {
    return try fn()
  } catch let e {
    if !label.isEmpty { errZ("\(label): ") }
    errL(e)
    exit(1)
  }
}
