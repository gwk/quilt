// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

#if os(OSX)
  import AppKit
#else
  import UIKit
#endif


extension CALayer {

  public var color: CRColor {
    // Like backgroundColor, but non-nil.
    get {
      if let cgColor = backgroundColor { return CRColor(cgColor: cgColor)! }
      return .clear
    }
    set { backgroundColor = (newValue == .clear ? nil : newValue.cgColor) }
  }

  public func updateContentsScale(_ contentsScale: CGFloat) {
    self.contentsScale = contentsScale
    if let sublayers = sublayers {
      for sublayer in sublayers {
          sublayer.updateContentsScale(contentsScale)
      }
    }
  }

  public func addSublayers(_ sublayers: CALayer...) {
    for layer in sublayers {
      addSublayer(layer)
    }
  }

  public func removeAllSublayers() {
    if let sublayers = sublayers {
      for layer in sublayers {
        layer.removeFromSuperlayer()
      }
    }
  }
}
