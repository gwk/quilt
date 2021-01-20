// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import AppKit
import CoreGraphics


open class TextView: StyledView {

  public required init?(coder: NSCoder) { super.init(coder: coder) }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    //textLayer.allowsFontSubpixelQuantization = true
  }

  public override func makeBackingLayer() -> CALayer {
    TextLayer()
  }


  // MARK: TextView

  public var textLayer: TextLayer { layer as! TextLayer }

  public var text: String {
    get { textLayer.text }
    set { textLayer.text = newValue }
  }

  public var font: CRFont {
    get { textLayer.font }
    set { textLayer.font = newValue }
  }

  public var textColor: CRColor {
    get { textLayer.textColor }
    set { textLayer.textColor = newValue }
  }

  public var edgeInsets: CREdgeInsets {
    get { textLayer.edgeInsets }
    set { textLayer.edgeInsets = newValue }
  }

  public var alignment: NSTextAlignment {
    get { textLayer.alignment }
    set { textLayer.alignment = newValue }
  }

  public var lineBreakMode: NSLineBreakMode {
    get { textLayer.lineBreakMode }
    set { textLayer.lineBreakMode = newValue }
  }
}
