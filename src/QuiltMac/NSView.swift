// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import AppKit


extension NSView {

  #if(false)
  // currently disabled (implemented in StyledView instead) because it causes crashes for view subclasses that also implement the property, e.g. SCNView.
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
