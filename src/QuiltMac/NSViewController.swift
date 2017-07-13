// © 2016 George King. Permission to use this file is granted in license.txt.

import AppKit
import Quilt


extension NSViewController {

  public func updateWindowObserver() {
    noteCenter.removeObserver(self, name: NSWindow.didChangeBackingPropertiesNotification, object: nil)
    noteCenter.addObserver(self,
                             selector: #selector(screenDidChange),
                             name: NSWindow.didChangeBackingPropertiesNotification,
                             object: view.window!)
    screenDidChange(nil)
  }

  @objc
  public func screenDidChange(_ note: Notification?) {}
}
