// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Darwin


public func stringForCurrentError() -> String {
  String(cString: Darwin.strerror(Darwin.errno))
}


public func mustOverride() -> Never { fatalError("must override") }


public func notImplemented(function: String = #function) {
  print("Not implemented: \(function).")
}
