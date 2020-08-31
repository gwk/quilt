// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

#if os(OSX)
  import AppKit
  #else
  import UIKit
#endif


extension NSLayoutConstraint.Attribute {

  public var isSome: Bool { self != .notAnAttribute }
}
