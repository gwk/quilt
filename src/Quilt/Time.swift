// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public typealias Time = F64

extension Time {
 public static var distantFuture: Time {
    return 1e300
  }
}


public func sysTime() -> Time {
  return ProcessInfo.processInfo.systemUptime
}


private var _appLaunchSysTime: Time = 0

public func initAppLaunchSysTime() {
  if _appLaunchSysTime != 0 {
    fatalError("recordAppLaunchSysTime(): must be called only once in main().")
  }
  _appLaunchSysTime = sysTime()
  assert(_appLaunchSysTime > 0)
}


public func appTime() -> Time {
  assert(_appLaunchSysTime > 0)
  return sysTime() - _appLaunchSysTime
}