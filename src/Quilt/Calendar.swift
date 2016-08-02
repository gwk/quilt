// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension Calendar {

  public func dateComponents(_ component: Component, from date: Date) -> DateComponents {
    return dateComponents([component], from: date)
  }
}


extension Calendar.Component {

  public static var preciseToDay: Set<Calendar.Component> {
    return [.era, .year, .month, .day]
  }

  public static var precise: Set<Calendar.Component> {
    return [.era, .year, .month, .day, .hour, .minute, .second, .nanosecond]
  }

  public static var timeOfDay: Set<Calendar.Component> {
    return [.hour, .minute, .second, .nanosecond]
  }

  public static var dayAndWeekday: Set<Calendar.Component> {
    return [.day, .weekday]
  }
}

