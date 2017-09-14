// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

#if os(OSX)
  import AppKit
  public typealias CRViewController = NSViewController
  #else
  import UIKit
  public typealias CRViewController = UIViewController
#endif

