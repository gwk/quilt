// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation


extension CountableRange where Bound == Int {

  public init(_ range: NSRange) { self = range.location..<(range.location + range.length) }
  public init(_ range: CFRange) { self = range.location..<(range.location + range.length) }
}
