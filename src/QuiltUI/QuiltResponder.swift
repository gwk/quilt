// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

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
  public override func keyDown(with e: NSEvent) {
    print("QuiltResponder keyDown: \(e)")
  }

  public override func keyUp(with e: NSEvent) {
    print("QuiltResponder keyUp: \(e)")
  }

  public override func flagsChanged(with e: NSEvent) {
    print("QuiltResponder flagsChanged: \(e)")
  }

  public override func mouseDown(with e: NSEvent) {
    print("QuiltResponder mouseDown: \(e)")
  }

  public override func mouseUp(with e: NSEvent) {
    print("QuiltResponder mouseUp: \(e)")
  }
  #endif
}
