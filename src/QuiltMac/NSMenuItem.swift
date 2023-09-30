// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit


extension NSMenuItem {

  convenience init(_ title: String, _ action: Selector? = nil, key: String = "") {
    self.init(title: title, action: action, keyEquivalent: key)
  }
}
