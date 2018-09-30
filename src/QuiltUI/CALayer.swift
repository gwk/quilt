// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

#if os(OSX)
  import AppKit
#else
  import UIKit
#endif


extension CALayer {

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
