// © 2016 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension NSMutableData {

  public func append<T>(_ el: T) { var el = el; self.append(&el, length: sizeof(T.self)) }
}

