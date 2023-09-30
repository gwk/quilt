// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
