// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

#if os(OSX)
import AppKit
#else
import UIKit
#endif


public enum EventKind {
  case kd
  case ku
  case fc
  case md
  case mu
  case mm
}


class QuiltResponder: CRResponder {
  //var handlers: [EventKind -> (CREvent, CRView) -> ()] = []

  #if os(OSX)
  override public func keyDown(with e: NSEvent) {
    print("QuiltResponder keyDown: \(e)")
  }

  override public func keyUp(with e: NSEvent) {
    print("QuiltResponder keyUp: \(e)")
  }

  override public func flagsChanged(with e: NSEvent) {
    print("QuiltResponder flagsChanged: \(e)")
  }

  override public func mouseDown(with e: NSEvent) {
    print("QuiltResponder mouseDown: \(e)")
  }

  override public func mouseUp(with e: NSEvent) {
    print("QuiltResponder mouseUp: \(e)")
  }
  #endif
}
