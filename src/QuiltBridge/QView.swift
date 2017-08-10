// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import CoreGraphics


public class QView: CRView {

  public required init?(coder decoder: NSCoder) {
    super.init(coder: decoder)
  }

  public override init(frame frameRect: CGRect) {
    super.init(frame: frameRect)
    #if os(OSX)
      self.wantsLayer = true
    #endif
  }

  #if os(OSX)

  override public var isFlipped: Bool { return true }

  override public var wantsUpdateLayer: Bool { return true }

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
