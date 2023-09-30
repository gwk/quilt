// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


extension DateFormatter {

  public convenience init(_ format: String) {
    self.init()
    dateFormat = format
  }

  public convenience init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style = .none) {
    self.init()
    self.dateStyle = dateStyle
    self.timeStyle = timeStyle
  }

  public convenience init(timeStyle: DateFormatter.Style) {
    self.init()
    self.dateStyle = .none
    self.timeStyle = timeStyle
  }
}
