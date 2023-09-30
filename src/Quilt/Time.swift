// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


public typealias Time = Double

extension Time {
 public static var distantFuture: Time { 1e300 }
}


public func sysTime() -> Time { ProcessInfo.processInfo.systemUptime }


private var _appLaunchSysTime: Time = 0

public func initAppLaunchSysTime() {
  if _appLaunchSysTime != 0 {
    fatalError("initAppLaunchSysTime(): must be called only once in main().")
  }
  _appLaunchSysTime = sysTime()
  assert(_appLaunchSysTime > 0)
}

public func appLaunchSysTime() -> Time {
  assert(_appLaunchSysTime != 0, "appLaunchSysTime(): initAppLaunchSysTime() must be called once in main().")
  return _appLaunchSysTime
}

public func appTime() -> Time {
  assert(_appLaunchSysTime > 0)
  return sysTime() - _appLaunchSysTime
}
