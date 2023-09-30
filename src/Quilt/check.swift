// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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


public func fatal<T>(label: String = "", _ message: T) -> Never {
  // Wrapper around `fatalError` that takes an optional label, followed by any value to decribe.
  let l = label.isEmpty ? "" : "\(label): "
  fatalError("\(l)\(message)")
}


// Assertions.

public func assertCond( _ condition: Bool, file:StaticString=#file, line:UInt=#line) {
  if _isDebugAssertConfiguration() {
    check(condition, label: "", "\(file):\(line): assertCond failed.")
  }
}

public func assertEq<T: Equatable>( _ l: T, _ r: T, file:StaticString=#file, line:UInt=#line) {
  if _isDebugAssertConfiguration() {
    check(l == r, label: "", "\(file):\(line): assertEq failed:\n  l: \(l)\n  r: \(r)")
  }
}

public func assertNE<T: Equatable>( _ l: T, _ r: T, file:StaticString=#file, line:UInt=#line) {
  if _isDebugAssertConfiguration() {
    check(l != r, label: "", "\(file):\(line): assertNE failed:\n  l: \(l)\n  r: \(r)")
  }
}

public func assertGE<T: Comparable>(_ l: T, _ r: T, file:StaticString=#file, line:UInt=#line) {
  if _isDebugAssertConfiguration() {
    check(l >= r, label: "", "\(file):\(line): assertGE failed:\n  l: \(l)\n  r: \(r)")
  }
}

public func assertGT<T: Comparable>(_ l: T, _ r: T, file:StaticString=#file, line:UInt=#line) {
  if _isDebugAssertConfiguration() {
    check(l >  r, label: "", "\(file):\(line): assertGT failed:\n  l: \(l)\n  r: \(r)")
  }
}

public func assertLE<T: Comparable>(_ l: T, _ r: T, file:StaticString=#file, line:UInt=#line) {
  if _isDebugAssertConfiguration() {
    check(l <= r, label: "", "\(file):\(line): assertLE failed:\n  l: \(l)\n  r: \(r)")
  }
}

public func assertLT<T: Comparable>(_ l: T, _ r: T, file:StaticString=#file, line:UInt=#line) {
  if _isDebugAssertConfiguration() {
    check(l <  r, label: "", "\(file):\(line): assertLT failed:\n  l: \(l)\n  r: \(r)")
  }
}
