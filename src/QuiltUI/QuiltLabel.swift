// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import AppKit
import CoreGraphics


public class QuiltLabel: QuiltView {

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    //textLayer.allowsFontSubpixelQuantization = true
  }

  public override func makeBackingLayer() -> CALayer {
    return QuiltTextLayer()
  }


  // MARK: QuiltLabel

  public var textLayer: QuiltTextLayer { return layer as! QuiltTextLayer }

  public var text: String {
    get { return textLayer.text }
    set { textLayer.text = newValue }
  }

  public var font: CRFont {
    get { return textLayer.font }
    set { textLayer.font = newValue }
  }

  public var textColor: CRColor {
    get { return textLayer.textColor }
    set { textLayer.textColor = newValue }
  }

  public var edgeInsets: CREdgeInsets {
    get { return textLayer.edgeInsets }
    set { textLayer.edgeInsets = newValue }
  }

  public var alignment: NSTextAlignment {
    get { return textLayer.alignment }
    set { textLayer.alignment = newValue }
  }

  public var lineBreakMode: NSLineBreakMode {
    get { return textLayer.lineBreakMode }
    set { textLayer.lineBreakMode = newValue }
  }
}
