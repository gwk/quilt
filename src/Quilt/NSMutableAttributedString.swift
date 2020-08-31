// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension NSMutableAttributedString {

  public var range: NSRange { NSRange(location: 0, length: length) }

  public func replaceContents(with string: String) {
    replaceCharacters(in: range, with: string)
  }

  public func addAttr(_ key: NSAttributedString.Key, _ value: Any) {
    addAttribute(key, value: value, range: range)
  }
}
