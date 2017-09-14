// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

#if os(OSX)
  import AppKit
  public typealias CRFlex = NSView.AutoresizingMask
#else
  import UIKit
  public typealias CRFlex = UIViewAutoresizing
#endif

import Quilt


public protocol FlexProtocol: OptionSet where Self.Element == Self {
  static var n: Self { get }
  static var w: Self { get }
  static var h: Self { get }
  static var l: Self { get }
  static var r: Self { get }
  static var t: Self { get }
  static var b: Self { get }

  static var size: Self { get }
  static var horiz: Self { get }
  static var vert: Self { get }
  static var pos: Self { get }
  static var wl: Self { get }
  static var wr: Self { get }
}

/* spurious compiler errors: "Cannot convert return expression of type '[Self]' to return type 'Self'".
extension FlexProtocol {
  public static var size: Self { return [w, h] }
  public static var horiz: Self { return [l, r] }
  public static var vert: Self { return [t, b] }
  public static var pos: Self { return [horiz, vert] }
  public static var wl: Self { return [w, l] }
  public static var wr: Self { return [w, r] }
}
*/

public typealias CAFlex = CAAutoresizingMask

extension CAFlex: FlexProtocol {
  public static var n: CAFlex { return [] }
  public static var w: CAFlex { return layerWidthSizable }
  public static var h: CAFlex { return layerHeightSizable }
  public static var l: CAFlex { return layerMinXMargin }
  public static var r: CAFlex { return layerMaxXMargin }
  public static var t: CAFlex { return layerMinYMargin }
  public static var b: CAFlex { return layerMaxYMargin }

  // temporary fix; see above.
  public static var size: CAFlex { return [w, h] }
  public static var horiz: CAFlex { return [l, r] }
  public static var vert: CAFlex { return [t, b] }
  public static var pos: CAFlex { return [horiz, vert] }
  public static var wl: CAFlex { return [w, l] }
  public static var wr: CAFlex { return [w, r] }
}


extension CRFlex: FlexProtocol {

  #if os(OSX)
  public static var n: CRFlex { return none }
  public static var w: CRFlex { return width }
  public static var h: CRFlex { return height }
  public static var l: CRFlex { return minXMargin }
  public static var r: CRFlex { return maxXMargin }
  public static var t: CRFlex { return minYMargin }
  public static var b: CRFlex { return maxYMargin }
  #else
  public static var n: CRFlex { return none }
  public static var w: CRFlex { return flexibleWidth }
  public static var h: CRFlex { return flexibleHeight }
  public static var l: CRFlex { return flexibleLeftMargin }
  public static var r: CRFlex { return flexibleRightMargin }
  public static var t: CRFlex { return flexibleTopMargin }
  public static var b: CRFlex { return flexibleBottomMargin }
  #endif

  // temporary fix; see above.
  public static var size: CRFlex { return [w, h] }
  public static var horiz: CRFlex { return [l, r] }
  public static var vert: CRFlex { return [t, b] }
  public static var pos: CRFlex { return [horiz, vert] }
  public static var wl: CRFlex { return [w, l] }
  public static var wr: CRFlex { return [w, r] }
}


public struct Flex: OptionSet, FlexProtocol {
  public let rawValue: U8

  public init(rawValue: U8) { self.rawValue = rawValue }
  public  init(_ flex: CAFlex) { rawValue = U8(flex.rawValue) }
  public init(_ flex: CRFlex) { rawValue = U8(flex.rawValue) } // assumes that CRFlex and CAFlex are the same.

  var asCAFlex: CAFlex { return CAFlex(rawValue: U32(rawValue)) }
  var asCRFlex: CRFlex { return CRFlex(rawValue: Uns(rawValue)) }

  public static let n: Flex = Flex(CAFlex.n)
  public static let w: Flex = Flex(CAFlex.w)
  public static let h: Flex = Flex(CAFlex.h)
  public static let l: Flex = Flex(CAFlex.l)
  public static let r: Flex = Flex(CAFlex.r)
  public static let t: Flex = Flex(CAFlex.t)
  public static let b: Flex = Flex(CAFlex.b)

  // temporary fix; see above.
  public static var size: Flex { return [w, h] }
  public static var horiz: Flex { return [l, r] }
  public static var vert: Flex { return [t, b] }
  public static var pos: Flex { return [horiz, vert] }
  public static var wl: Flex { return [w, l] }
  public static var wr: Flex { return [w, r] }
}

