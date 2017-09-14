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
public class QTextLayer: CALayer {

  // MARK: QTextLayer

  public var text: String = "" {
    didSet { setNeedsDisplay() }
  }

  public var font: CRFont = CRFont.systemFont(ofSize: 12) {
    didSet { setNeedsDisplay() }
  }

  public var textColor: CRColor = .black {
    didSet { setNeedsDisplay() }
  }

  public var edgeInsets: CREdgeInsets = CREdgeInsets(l: 2, t: 2, r: 2, b: 2) {
    didSet { setNeedsDisplay() }
  }

  public var alignment: NSTextAlignment {
    get { return _paragraphStyle.alignment }
    set {
      _paragraphStyle.alignment = newValue
      setNeedsDisplay()
    }
  }

  public var lineBreakMode: NSParagraphStyle.LineBreakMode {
    get { return _paragraphStyle.lineBreakMode }
    set {
      _paragraphStyle.lineBreakMode = newValue
      setNeedsDisplay()
    }
  }

  private var _paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()


  // MARK: CALayer

  override public func draw(in ctx: CGContext) {
    let textBounds = bounds.insetBy(edgeInsets)

    // TODO: use Core Text.
    ctx.withGraphicsContext(flipped: true) {
      text.draw(
        with: textBounds,
        options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine],
        attributes: [
          //.backgroundColor
          //.baselineOffset
          //.cursor
          //.expansion
          .font: font,
          .foregroundColor: textColor,
          //.kern
          //.ligature
          //.link
          //.markedClauseSegment
          //.obliqueness
          .paragraphStyle: _paragraphStyle,
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
        ],
        context: nil)
    }
  }
}
