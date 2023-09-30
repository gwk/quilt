// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

#if os(OSX)
  import AppKit
  public typealias CRViewController = NSViewController
  #else
  import UIKit
  public typealias CRViewController = UIViewController
#endif
