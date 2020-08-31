// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension Calendar {

  public func dateComponents(_ component: Component, from date: Date) -> DateComponents {
    dateComponents([component], from: date)
  }
}


extension Calendar.Component {

  public static var preciseToDay: Set<Calendar.Component> {
    [.era, .year, .month, .day]
  }

  public static var precise: Set<Calendar.Component> {
    [.era, .year, .month, .day, .hour, .minute, .second, .nanosecond]
  }

  public static var timeOfDay: Set<Calendar.Component> {
    [.hour, .minute, .second, .nanosecond]
  }

  public static var dayAndWeekday: Set<Calendar.Component> {
    [.day, .weekday]
  }
}

