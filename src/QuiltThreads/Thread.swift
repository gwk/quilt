// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public func assertMainThread() {
  assert(Thread.isMainThread)
}

public func assertChildThread() {
  assert(!Thread.isMainThread)
}

extension Foundation.Thread {}
