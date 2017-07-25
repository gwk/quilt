// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

#if os(OSX)
  import AppKit
  public typealias CREvent = NSEvent
  #else
  import UIKit
  public typealias CREvent = UIEvent
#endif

import Quilt


extension CREvent {
  public var appTime: TimeInterval { return timestamp - appLaunchSysTime() } // timestamp is relative to systemUptime.
}
