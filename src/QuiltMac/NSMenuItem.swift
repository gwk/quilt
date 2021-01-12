// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import AppKit


extension NSMenuItem {

  convenience init(_ title: String, _ action: Selector? = nil, key: String = "") {
    self.init(title: title, action: action, keyEquivalent: key)
  }
}
