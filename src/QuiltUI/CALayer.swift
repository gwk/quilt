// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
