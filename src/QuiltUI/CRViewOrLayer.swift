// © 2017 George King. Permission to use this file is granted in license-quilt.txt.


#if os(OSX)
  import AppKit
#else
  import UIKit
#endif

import Quilt


public protocol CRViewOrLayer: class {

  var bounds: CGRect { get set }
  var frame: CGRect { get set }
  var isHidden: Bool { get set }
  var isOpaque: Bool { get }

  var flex: Flex { get set }

  func add(toParentView parent: CRView)

  func removeFromParent()
}


extension CRViewOrLayer {

  public var o: CGPoint {
    get { return frame.origin }
    set { frame.origin = newValue }
  }

  public var s: CGSize {
    get { return frame.size }
    set { frame.size = newValue }
  }

  public var x: CGFloat {
    get { return frame.origin.x }
    set { frame.origin.x = newValue }
  }

  public var y: CGFloat {
    get { return frame.origin.y }
    set { frame.origin.y = newValue }
  }

  public var w: CGFloat {
    get { return frame.size.width }
    set { frame.size.width = newValue }
  }

  public var h: CGFloat {
    get { return frame.size.height }
    set { frame.size.height = newValue }
  }

  public var l: CGFloat {
    get { return frame.origin.x }
    set { frame.origin.x = newValue }
  }

  public var t: CGFloat {
    get { return frame.origin.y }
    set { frame.origin.y = newValue }
  }

  public var r: CGFloat {
    get { return x + w }
    set { x = newValue - w }
  }

  public var b: CGFloat {
    get { return y + h }
    set { y = newValue - h }
  }
}


extension CRView: CRViewOrLayer {

  public var flex: Flex {
    get { return Flex(autoresizingMask) }
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
    get { return Flex(autoresizingMask) }
    set { autoresizingMask = newValue.asCAFlex }
  }

  public func add(toParentView parent: CRView) {
    parent.layer!.addSublayer(self)
  }

  public func removeFromParent() {
    removeFromSuperlayer()
  }
}
