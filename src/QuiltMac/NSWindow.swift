// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import AppKit
import QuiltBridge


extension NSWindow {

  public convenience init(
    origin: CGPoint = CGPoint(0, 0),
    viewSize: CGSize,
    fixedAspect: Bool = false,
    styleMask: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable],
    deferred: Bool = false,
    screen: NSScreen? = nil,
    viewController: NSViewController) {

      self.init(
        contentRect: CGRect.zero, // gets clobbered by controller view initial size.
        styleMask: styleMask,
        backing: NSWindow.BackingStoreType.buffered, // the only modern mode.
        defer: deferred,
        screen: screen)

      contentViewController = viewController
      bind(NSBindingName.title, to: viewController, withKeyPath: "title", options: nil)
      self.origin = origin
      setContentSize(viewSize)
      if fixedAspect {
        contentAspectRatio = viewSize
      }
  }

  public var viewSize: CGSize {
    get {
      return contentRect(forFrameRect: frame).size
    }
    set {
      setContentSize(newValue)
    }
  }
}
