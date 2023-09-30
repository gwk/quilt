// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


public func assertMainThread() {
  assert(Thread.isMainThread)
}

public func assertChildThread() {
  assert(!Thread.isMainThread)
}

extension Foundation.Thread {}
