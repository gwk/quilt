// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


public func stringForCurrentError() -> String {
  return String(cString: strerror(errno))
}

public func checkError(_ error: ErrorProtocol?) {
  if let error = error {
    fail("error: \(error)")
  }
}
