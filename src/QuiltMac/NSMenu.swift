// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import AppKit


extension NSMenu {

  public convenience init(title: String, parentItem: NSMenuItem) {
    self.init(title: title)
    parentItem.submenu = self
  }


  public convenience init(title: String, superMenu: NSMenu) {
    self.init(title: title)
    let parentItem = NSMenuItem(title: title, action: nil, keyEquivalent: "")
    parentItem.submenu = self
    superMenu.addItem(parentItem)
  }


  @discardableResult
  public func add(_ title: String, _ action: Selector?, key: String = "") -> QuiltObservingMenuItem {
    let item = QuiltObservingMenuItem(title: title, action: action, keyEquivalent: key)
    addItem(item)
    return item
  }
}
