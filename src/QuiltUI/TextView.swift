// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation
import AppKit
import CoreGraphics


open class TextView: StyledView {

  public required init?(coder: NSCoder) { super.init(coder: coder) }

  override public init(frame: CGRect) {
    super.init(frame: frame)
    //textLayer.allowsFontSubpixelQuantization = true
  }

  override public func makeBackingLayer() -> CALayer {
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
