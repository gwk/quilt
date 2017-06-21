// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


public func stringForCurrentError() -> String {
  return String(cString: strerror(Darwin.errno))
}

public func checkError(_ error: Error?) {
  if let error = error {
    fail("error: \(error)")
  }
}
