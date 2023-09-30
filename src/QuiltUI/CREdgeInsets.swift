// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

#if os(OSX)
  import AppKit
  public typealias CREdgeInsets = NSEdgeInsets
  #else
  import UIKit
  public typealias CREdgeInsets = UIEdgeInsets
#endif


extension CREdgeInsets {

  public var l: Double { left }
  public var t: Double { top }
  public var r: Double { right }
  public var b: Double { bottom }

  public init(l: Double = 0, t: Double = 0, r: Double = 0, b: Double = 0) {
    self.init(top: t, left: l, bottom: b, right: r)
  }

  public init(x: Double = 0, y: Double = 0) {
    self.init(top: y, left: x, bottom: y, right: x)
  }

  public static let zero = CREdgeInsets(x: 0, y: 0)
}
