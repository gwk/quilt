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


class QKResponder: CRResponder {
  //var handlers: [EventKind -> (CREvent, CRView) -> ()] = []

  #if os(OSX)
  public override func keyDown(with e: CREvent) {
    print("QKResponder keyDown: \(e)")
  }

  public override func keyUp(with e: CREvent) {
    print("QKResponder keyUp: \(e)")
  }

  public override func flagsChanged(with e: CREvent) {
    print("QKResponder flagsChanged: \(e)")
  }

  public override func mouseDown(with e: CREvent) {
    print("QKResponder mouseDown: \(e)")
  }

  public override func mouseUp(with e: CREvent) {
    print("QKResponder mouseUp: \(e)")
  }
  #endif
}
