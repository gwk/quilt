// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
