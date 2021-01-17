// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


public func stringForCurrentError() -> String {
  String(cString: Darwin.strerror(Darwin.errno))
}


public func mustOverride() -> Never { fatalError("must override") }


public func notImplemented(function: String = #function) {
  print("Not implemented: \(function).")
}
