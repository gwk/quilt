// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import AppKit
import CoreGraphics


public class QLabel: QView {

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    textLayer.allowsFontSubpixelQuantization = true
    textLayer.contentsScale = 2 // hack.
    // Correctly setting the scale on macOS is complex;
    // windows can transition between screens with different scale factors,
    // and screens can be added or removed while the application is running.
  }

  public override func makeBackingLayer() -> CALayer {
    return CATextLayer()
  }

  var text: String = "" {
    didSet {
      textLayer.string = text as NSString
    }
  }

  var font: CRFont {
    get { return textLayer.font as! CRFont }
    set {
      textLayer.font = newValue
      textLayer.fontSize = newValue.pointSize
    }
  }


  public var textColor: CRColor {
    get {
      return CRColor(cgColor: textLayer.foregroundColor ?? .white)!
    }
    set {
      textLayer.foregroundColor = newValue.cgColor
      setNeedsDisplay()
    }
  }

  var textLayer: CATextLayer { return layer as! CATextLayer }
}
