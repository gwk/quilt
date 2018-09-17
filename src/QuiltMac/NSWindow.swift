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
    viewController: NSViewController) {

    self.init(
      contentRect: CGRect.zero, // Gets clobbered by controller view initial size.
      styleMask: styleMask,
      backing: NSWindow.BackingStoreType.buffered, // the only modern mode.
      defer: deferred,
      screen: screen)

    isReleasedWhenClosed = false

    contentViewController = viewController
    delegate = viewController as? NSWindowDelegate

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
        errL("dissolving window: \(window); controller: \(window.contentViewController.optDesc)")
        window.delegate = nil
        window.contentViewController = nil
      }
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

  public func observeCloseOnce(block: @escaping (NSWindow)->Void) -> Observer {
    return noteCenter.observeOnce(self, name: NSWindow.willCloseNotification) {
      block($0.object as! NSWindow)
    }
  }

  public func observeBackingProperties(block: @escaping (NSWindow, Flt, NSColorSpace)->Void) -> Observer {
    return noteCenter.addObserver(
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
