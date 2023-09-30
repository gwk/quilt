// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit
import Quilt


open class QuiltWindow: NSWindow {

  deinit {
    errL("deinit: \(self)")
  }
}
