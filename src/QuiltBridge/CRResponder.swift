// © 2014 George King. Permission to use this file is granted in license-qk.txt.

#if os(OSX)
  import AppKit
  public typealias CRResponder = NSResponder
  #else
  import UIKit
  public typealias CRResponder = UIResponder
#endif


extension CRResponder {

  #if os(OSX)
  public func insertNextResponder(_ responder: CRResponder) {
    responder.nextResponder = self.nextResponder
    self.nextResponder = responder
  }
  #endif
}
