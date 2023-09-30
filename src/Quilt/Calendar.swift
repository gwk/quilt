// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
