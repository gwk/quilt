

import AppKit


extension NSView {

  public var contentsScale: CGFloat {
    return (layer?.contentsScale) ?? (window?.backingScaleFactor) ?? 1
  }

  public func updateContentsScale(_ contentsScale: CGFloat) {
    if let layer = layer {
      layer.updateContentsScale(contentsScale)
    }
    for subview in subviews {
      subview.updateContentsScale(contentsScale)
    }
  }

  #if(false)
  // currently disabled (implemented in QView instead) because it causes crashes for view subclasses that also implement the property, e.g. SCNView.
  public var backgroundColor: CRColor? {
    get {
      guard let cgColor = layer?.backgroundColor else { return nil }
      return CRColor(cgColor: cgColor)
    }
    set {
      layer!.backgroundColor = newValue?.cgColor
      setNeedsDisplay()
    }
  }
  #endif
}
