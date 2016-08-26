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

public func fail(_ message: String) -> Never {
  std_err.write("error: ")
  std_err.write(message)
  std_err.write("\n")
  exit(1)
}

public func fail(error: Error) -> Never {
  std_err.write("error: ")
  std_err.write(String(describing: error))
  std_err.write("\n")
  exit(1)
}

public func guarded<R>(label: String = "error: ", _ fn: () throws -> R) -> R {
  do {
    return try fn()
  } catch let e {
    std_err.write(label)
    std_err.write(String(describing: e))
    std_err.write("\n")
    exit(1)
  }
}
