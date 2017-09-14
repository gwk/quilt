// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation


extension NSRange {

  public init(_ range: CountableRange<Int>) {
    self = NSMakeRange(range.lowerBound, range.upperBound - range.lowerBound)
  }

  public static let zero = NSMakeRange(0, 0)
}


extension CFRange {

  public init(_ range: CountableRange<Int>) {
    self = CFRangeMake(range.lowerBound, range.upperBound - range.lowerBound)
  }

  public static let zero = CFRangeMake(0, 0)
}
