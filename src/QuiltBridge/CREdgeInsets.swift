// © 2015 George King. Permission to use this file is granted in license-quilt.txt.

#if os(OSX)
  import AppKit
  public typealias CREdgeInsets = NSEdgeInsets
  #else
  import UIKit
  public typealias CREdgeInsets = UIEdgeInsets
#endif


extension CREdgeInsets {

  public var l: Flt { return left }
  public var t: Flt { return top }
  public var r: Flt { return right }
  public var b: Flt { return bottom }

  public init(l: Flt = 0, t: Flt = 0, r: Flt = 0, b: Flt = 0) {
    self.init(top: t, left: l, bottom: b, right: r)
  }

  public init(x: Flt = 0, y: Flt = 0) {
    self.init(top: y, left: x, bottom: y, right: x)
  }
}
