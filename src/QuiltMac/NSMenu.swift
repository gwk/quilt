// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import AppKit


extension NSMenu {

  @discardableResult
  public func add(_ title: String, _ action: Selector?, key: String = "") -> QuiltObservingMenuItem {
    let item = QuiltObservingMenuItem(title: title, action: action, keyEquivalent: key)
    addItem(item)
    return item
  }


  @discardableResult
  public func add(submenu: NSMenu) -> NSMenu {
    let item = NSMenuItem(title: submenu.title, action: nil, keyEquivalent: "")
    item.submenu = submenu
    addItem(item)
    return submenu
  }
}
