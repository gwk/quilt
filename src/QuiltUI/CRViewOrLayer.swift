// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


#if os(OSX)
  import AppKit
#else
  import UIKit
#endif

import Quilt


public protocol CRViewOrLayer: AnyObject {

  var bounds: CGRect { get set }
  var frame: CGRect { get set }
  var isHidden: Bool { get set }
  var isOpaque: Bool { get }

  var flex: Flex { get set }

  func add(toParentView parent: CRView)

  func removeFromParent()

  func setNeedsLayout()
}


extension CRViewOrLayer {

  public var o: CGPoint {
    get { frame.origin }
    set { frame.origin = newValue }
  }

  public var s: CGSize {
    get { frame.size }
    set { frame.size = newValue }
  }

  public var x: CGFloat {
    get { frame.origin.x }
    set { frame.origin.x = newValue }
  }

  public var y: CGFloat {
    get { frame.origin.y }
    set { frame.origin.y = newValue }
  }

  public var w: CGFloat {
    get { frame.size.width }
    set { frame.size.width = newValue }
  }

  public var h: CGFloat {
    get { frame.size.height }
    set { frame.size.height = newValue }
  }

  public var l: CGFloat {
    get { frame.origin.x }
    set { frame.origin.x = newValue }
  }

  public var t: CGFloat {
    get { frame.origin.y }
    set { frame.origin.y = newValue }
  }

  public var r: CGFloat {
    get { x + w }
    set { x = newValue - w }
  }

  public var b: CGFloat {
    get { y + h }
    set { y = newValue - h }
  }
}


extension CRView: CRViewOrLayer {

  public var flex: Flex {
    get { Flex(autoresizingMask) }
    set { autoresizingMask = newValue.asCRFlex }
  }

  public func add(toParentView parent: CRView) {
    parent.addSubview(self)
  }

  public func removeFromParent() {
    removeFromSuperview()
  }

  // MARK: CRView additions

  public func add(viewOrLayer: CRViewOrLayer) {
    // Wrapper method to invert the inversion required by protocol inheritance.
    viewOrLayer.add(toParentView: self)
  }
}


extension CALayer: CRViewOrLayer {

  public var flex: Flex {
    get { Flex(autoresizingMask) }
    set { autoresizingMask = newValue.asCAFlex }
  }

  public func add(toParentView parent: CRView) {
    parent.layer!.addSublayer(self)
  }

  public func removeFromParent() {
    removeFromSuperlayer()
  }
}
