// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

#if os(OSX)
  import AppKit
  public typealias CRFlex = NSView.AutoresizingMask
#else
  import UIKit
  public typealias CRFlex = UIViewAutoresizing
#endif

import Quilt
import QuiltArithmetic


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
  public static var size: Self { [w, h] }
  public static var horiz: Self { [l, r] }
  public static var vert: Self { [t, b] }
  public static var pos: Self { [horiz, vert] }
  public static var wl: Self { [w, l] }
  public static var wr: Self { [w, r] }
}
*/

public typealias CAFlex = CAAutoresizingMask

extension CAFlex: FlexProtocol {
  public static var n: CAFlex { [] }
  public static var w: CAFlex { layerWidthSizable }
  public static var h: CAFlex { layerHeightSizable }
  public static var l: CAFlex { layerMinXMargin }
  public static var r: CAFlex { layerMaxXMargin }
  public static var t: CAFlex { layerMinYMargin }
  public static var b: CAFlex { layerMaxYMargin }

  // temporary fix; see above.
  public static var size: CAFlex { [w, h] }
  public static var horiz: CAFlex { [l, r] }
  public static var vert: CAFlex { [t, b] }
  public static var pos: CAFlex { [horiz, vert] }
  public static var wl: CAFlex { [w, l] }
  public static var wr: CAFlex { [w, r] }
}


extension CRFlex: FlexProtocol {

  #if os(OSX)
  public static var n: CRFlex { none }
  public static var w: CRFlex { width }
  public static var h: CRFlex { height }
  public static var l: CRFlex { minXMargin }
  public static var r: CRFlex { maxXMargin }
  public static var t: CRFlex { minYMargin }
  public static var b: CRFlex { maxYMargin }
  #else
  public static var n: CRFlex { none }
  public static var w: CRFlex { flexibleWidth }
  public static var h: CRFlex { flexibleHeight }
  public static var l: CRFlex { flexibleLeftMargin }
  public static var r: CRFlex { flexibleRightMargin }
  public static var t: CRFlex { flexibleTopMargin }
  public static var b: CRFlex { flexibleBottomMargin }
  #endif

  // temporary fix; see above.
  public static var size: CRFlex { [w, h] }
  public static var horiz: CRFlex { [l, r] }
  public static var vert: CRFlex { [t, b] }
  public static var pos: CRFlex { [horiz, vert] }
  public static var wl: CRFlex { [w, l] }
  public static var wr: CRFlex { [w, r] }
}


public struct Flex: OptionSet, FlexProtocol {
  public let rawValue: U8

  public init(rawValue: U8) { self.rawValue = rawValue }
  public  init(_ flex: CAFlex) { rawValue = U8(flex.rawValue) }
  public init(_ flex: CRFlex) { rawValue = U8(flex.rawValue) } // assumes that CRFlex and CAFlex are the same.

  var asCAFlex: CAFlex { CAFlex(rawValue: U32(rawValue)) }
  var asCRFlex: CRFlex { CRFlex(rawValue: Uns(rawValue)) }

  public static let n: Flex = Flex(CAFlex.n)
  public static let w: Flex = Flex(CAFlex.w)
  public static let h: Flex = Flex(CAFlex.h)
  public static let l: Flex = Flex(CAFlex.l)
  public static let r: Flex = Flex(CAFlex.r)
  public static let t: Flex = Flex(CAFlex.t)
  public static let b: Flex = Flex(CAFlex.b)

  // temporary fix; see above.
  public static var size: Flex { [w, h] }
  public static var horiz: Flex { [l, r] }
  public static var vert: Flex { [t, b] }
  public static var pos: Flex { [horiz, vert] }
  public static var wl: Flex { [w, l] }
  public static var wr: Flex { [w, r] }
}
