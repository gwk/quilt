// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


public func check(_ condition: Bool, _ message: @autoclosure () -> String) {
  if !condition {
    fail(message())
  }
}

public func check(_ condition: Bool, file: StaticString = #file, line: UInt = #line) {
  if !condition {
    fatalError("check failure", file: file, line: line)
  }
}

public func fail<T>(prefix: String = "error: ", _ item: T) -> Never {
  errZ(prefix)
  errL(item)
  exit(1)
}

public func guarded<R>(label: String = "error", _ fn: () throws -> R) -> R {
  do {
    return try fn()
  } catch let e {
    errL("\(label): \(e)")
    exit(1)
  }
}
