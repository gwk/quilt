// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

#if os(OSX)
  import AppKit
  public typealias CREvent = NSEvent
  #else
  import UIKit
  public typealias CREvent = UIEvent
#endif

import Quilt


extension CREvent {
  public var appTime: TimeInterval { timestamp - appLaunchSysTime() } // timestamp is relative to systemUptime.



  public var prevLocationInWindow: CGPoint {
    let p = locationInWindow
    return CGPoint(p.x - deltaX, p.y + deltaY) // Note the inverted deltaY; may be related to NSView.isFlipped.
  }


  public func location(in view: NSView) -> CGPoint {
    return view.convert(locationInWindow, from: nil) // Nil indicates that convert should use window coordinates.
  }


  public func prevLocation(in view: NSView) -> CGPoint {
    return view.convert(prevLocationInWindow, from: nil) // Nil indicates that convert should use window coordinates.
  }
}
