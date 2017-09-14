// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension CountableRange where Bound == Int {

  public init(_ range: NSRange) { self = range.location..<(range.location + range.length) }
  public init(_ range: CFRange) { self = range.location..<(range.location + range.length) }
}
