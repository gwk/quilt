// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Darwin


public func renameFile(from fromPath: Path, to toPath: Path) {
  if Darwin.rename(fromPath.expandUser, toPath.expandUser) != 0 {
    fail("renameFile(from: \(fromPath), to: \(toPath)) failed: \(stringForCurrentError())") // TODO: throw.
  }
}
