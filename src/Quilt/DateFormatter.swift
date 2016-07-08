// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension DateFormatter {

  public convenience init(_ format: String) {
    self.init()
    dateFormat = format
  }

#if false // TODO: reinstate once xcode8b2 bug is fixed.
  public convenience init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style = .noStyle) {
    self.init()
    self.dateStyle = dateStyle
    self.timeStyle = timeStyle
  }

  public convenience init(timeStyle: DateFormatter.Style) {
    self.init()
    self.dateStyle = .noStyle
    self.timeStyle = timeStyle
  }
#endif
}
