// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import AppKit


extension NSMenu {

  @discardableResult
  public func add(_ title: String, _ action: Selector?, object: Any? = nil, key: String = "") -> QuiltObservingMenuItem {
    let item = QuiltObservingMenuItem(title: title, action: action, keyEquivalent: key)
    item.representedObject = object
    addItem(item)
    return item
  }


  @discardableResult
  public func add(submenu: NSMenu) -> NSMenuItem {
    let item = NSMenuItem(title: submenu.title, action: nil, keyEquivalent: "")
    item.submenu = submenu
    addItem(item)
    return item
  }


  @discardableResult
  public func addToggle<Observable: NSObject>(
    _ title: String,
    key: String = "",
    observable: Observable,
    keyPath: WritableKeyPath<Observable, Bool>,
    inverted: Bool = false) -> QuiltToggleMenuItem<Observable> {

    let item = QuiltToggleMenuItem(title: title, key: key, observable: observable, keyPath: keyPath, inverted: inverted)
    addItem(item)
    return item
  }


  @discardableResult
  public func addSeparator() -> NSMenuItem {
    let sep = NSMenuItem.separator()
    self.addItem(sep)
    return sep
  }
}
