// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension Calendar.Unit {

  public static var preciseToDay: Calendar.Unit {
    return [.era, .year, .month, .day]
  }

  public static var precise: Calendar.Unit {
    return [.era, .year, .month, .day, .hour, .minute, .second, .nanosecond]
  }

  public static var timeOfDay: Calendar.Unit {
    return [.hour, .minute, .second, .nanosecond]
  }

  public static var dayAndWeekday: Calendar.Unit {
    return [.day, .weekday]
  }
}

