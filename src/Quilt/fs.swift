// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Darwin


public func renameFile(from fromPath: Path, to toPath: Path) {
  if Darwin.rename(fromPath.expandUser, toPath.expandUser) != 0 {
    fail("renameFile(from: \(fromPath), to: \(toPath)) failed: \(stringForCurrentError())") // TODO: throw.
  }
}
