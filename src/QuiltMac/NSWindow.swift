// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import AppKit
import Quilt
import QuiltUI


extension NSWindow {

  public convenience init(
    origin: CGPoint = .zero,
    viewSize: CGSize = .zero,
    fillScreen: Bool = false,
    fixedAspect: Bool = false,
    styleMask: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable],
    deferred: Bool = true,
    screen: NSScreen? = nil,
    dissolveOnClose: Bool, // Nullify delegate/contentViewController.
    view: NSView? = nil,
    viewController: NSViewController? = nil) {

    precondition(
      view == nil || viewController == nil,
      "NSWindow: cannot specify both view and viewController:\n  \(view!)\n  \(viewController!)")

    self.init(
      contentRect: CGRect.zero, // Gets clobbered by content view initial size.
      styleMask: styleMask,
      backing: NSWindow.BackingStoreType.buffered, // the only modern mode.
      defer: deferred,
      screen: screen)

    isReleasedWhenClosed = false

    if let view = view {
      contentView = view
      delegate = view as? NSWindowDelegate

    } else if let viewController = viewController {
      contentViewController = viewController
      delegate = viewController as? NSWindowDelegate
    }

    self.origin = origin
    if viewSize.w > 0 && viewSize.h > 0 {
      setContentSize(viewSize)
    }
    if fillScreen {
      if let screen = screen ?? NSScreen.main {
        self.setFrame(screen.visibleFrame, display: false)
      }
    }
    if fixedAspect {
      contentAspectRatio = viewSize
    }

    if dissolveOnClose {
      _ = observeCloseOnce {
        (window) in
        errL("dissolving window: \(window)")
        window.contentView = nil
        window.contentViewController = nil
        window.delegate = nil
      }
    }
  }

  public var viewSize: CGSize {
    get {
      contentRect(forFrameRect: frame).size
    }
    set {
      setContentSize(newValue)
    }
  }

  public func observeCloseOnce(block: @escaping (NSWindow)->Void) -> Observer {
    noteCenter.observeOnce(self, name: NSWindow.willCloseNotification) {
      block($0.object as! NSWindow)
    }
  }

  public func observeBackingProperties(block: @escaping (NSWindow, Flt, NSColorSpace)->Void) -> Observer {
    noteCenter.addObserver(
      forName: NSWindow.didChangeBackingPropertiesNotification,
      object: self,
      queue: .main,
      using: {
        (note) in
        let window = note.object as! NSWindow
        let oldScaleFactor = note.userInfo![NSWindow.oldScaleFactorUserInfoKey] as! NSNumber
        let oldColorSpace = note.userInfo![NSWindow.oldColorSpaceUserInfoKey] as! NSColorSpace
        block(window, Flt(oldScaleFactor.doubleValue), oldColorSpace)
    })
  }
}
