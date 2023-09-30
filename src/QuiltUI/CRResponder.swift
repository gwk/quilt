// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

#if os(OSX)
  import AppKit
  public typealias CRResponder = NSResponder
  #else
  import UIKit
  public typealias CRResponder = UIResponder
#endif


extension CRResponder {

  public func getResponder<R: CRResponder>(_ type: R.Type) -> R? {
    var responder = self.nextResponder
    while let r = responder {
      if let r = r as? R { return r }
      responder = r.nextResponder
    }
    return nil
  }


  #if os(OSX)
  public func insertNextResponder(_ responder: CRResponder) {
    responder.nextResponder = self.nextResponder
    self.nextResponder = responder
  }
  #endif
}
