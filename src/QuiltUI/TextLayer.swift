// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import CoreGraphics
import CoreText
import Foundation
#if os(OSX)
  import AppKit
#else
  import UIKit
#endif


@available(macOS 10.11, *)
public class TextLayer: StyledLayer {

  // MARK: TextLayer

  public var text: String = "" {
    didSet { setNeedsDisplay() }
  }

  public var font: CRFont = CRFont.systemFont(ofSize: 12) {
    didSet { setNeedsDisplay() }
  }

  public var textColor: CRColor = .black {
    didSet { setNeedsDisplay() }
  }

  public var edgeInsets: CREdgeInsets = .zero {
    didSet { setNeedsDisplay() }
  }

  public var alignment: NSTextAlignment = .left {
    didSet { setNeedsDisplay() }
  }

  public var lineBreakMode: NSLineBreakMode = .byWordWrapping {
    didSet { setNeedsDisplay() }
  }

  private var _attrString = NSMutableAttributedString()
  private var _truncationString = NSMutableAttributedString(string: "\u{2026}") // ellipsis.
  private var _style = NSMutableParagraphStyle()

  private lazy var _framesetter = CTFramesetter.make(attributedString: _attrString)
  private lazy var _truncationLine = CTLine.make(attrString: _truncationString)

  // MARK: CALayer

  public required init?(coder: NSCoder) { fatalError() }

  public override init() {
    super.init()
    needsDisplayOnBoundsChange = true
    isOpaque = true
  }

  public override init(layer: Any) {
    super.init(layer: layer)
    let l = layer as! TextLayer
    text = l.text
    font = l.font
    textColor = l.textColor
    edgeInsets = l.edgeInsets
    alignment = l.alignment
    lineBreakMode = l.lineBreakMode
  }

  private func updateAttrs(_ attrString: NSMutableAttributedString) {
    //.backgroundColor
    //.baselineOffset
    //.cursor
    //.expansion
    attrString.addAttr(.font, font)
    attrString.addAttr(.foregroundColor, textColor)
    //.kern
    //.ligature
    //.link
    //.markedClauseSegment
    //.obliqueness
    attrString.addAttr(.paragraphStyle, _style)
    //.shadow
    //.spellingState
    //.strikethroughColor
    //.strikethroughStyle
    //.strokeColor
    //.strokeWidth
    //.superscript
    //.textAlternatives
    //.textEffect
    //.toolTip
    //.underlineColor
    //.underlineStyle
  }

  override public func draw(in ctx: CGContext) {

    _style.alignment = alignment
    _style.lineBreakMode = lineBreakMode

    _attrString.replaceContents(with: text)
    updateAttrs(_attrString)
    updateAttrs(_truncationString)

    let textBounds = bounds.insetBy(edgeInsets)
    //let (suggestedSize, _) = _framesetter.suggestFrameSize(constraintSize: CGSize(textBounds.width, .infinity))
    let frame = _framesetter.createFrame(bounds: textBounds)
    if let backgroundColor = backgroundColor {
      ctx.setFillColor(backgroundColor)
      ctx.fill(bounds)
    if isOpaque {
      ctx.setAllowsFontSmoothing(true)
      ctx.setAllowsFontSubpixelPositioning(true)
      ctx.setAllowsFontSubpixelQuantization(true)
      ctx.setShouldSmoothFonts(true)
      ctx.setShouldSubpixelPositionFonts(true)
      ctx.setShouldSubpixelQuantizeFonts(true)
      }
    }
    ctx.textMatrix = .identity
    ctx.translateBy(x: textBounds.origin.x, y: bounds.size.height - textBounds.origin.y)
    ctx.scaleBy(x: 1.0, y: -1.0)
    frame.draw(ctx: ctx, attrString: _attrString, width:textBounds.width, truncationType: .end, truncationLine: _truncationLine)
  }
}