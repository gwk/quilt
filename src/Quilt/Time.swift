// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


public typealias Time = F64

extension Time {
 public static var distantFuture: Time {
    return 1e300
  }
}


public func sysTime() -> Time {
  return ProcessInfo.processInfo().systemUptime
}

// note: this is lazily evaluated, so it must be accessed at launch time to initialize accurately.
// TODO: remove and just use sysTime instead?
public let appLaunchSysTime: Time = sysTime()

public func initAppLaunchSysTime() -> Time {
  return appLaunchSysTime
}

public func appTime() -> Time {
  return sysTime() - appLaunchSysTime
}
