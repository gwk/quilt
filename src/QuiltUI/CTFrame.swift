// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import Foundation
import CoreText


extension CTFrame {

  public var lines: [CTLine] { return CTFrameGetLines(self) as! [CTLine] }

  public var path: CGPath { return CTFrameGetPath(self) }

  public var range: CountableRange<Int> { return CountableRange(CTFrameGetStringRange(self)) }

  public func getLinesAndOrigins() -> ([CTLine], [CGPoint]) {
    let lines = self.lines
    var origins = [CGPoint](repeating: .zero, count: lines.count)
    CTFrameGetLineOrigins(self, CFRangeMake(0, lines.count), &origins)
    return (lines, origins)
  }

  // TODO: frameAttributes: CTFrameGetFrameAttributes
  // CTFrameGetVisibleStringRange
  // ...

  public func draw(ctx: CGContext) { CTFrameDraw(self, ctx) }

  public func draw(ctx: CGContext, attrString: NSAttributedString, width: Flt, truncationType: CTLineTruncationType = .end, truncationLine: CTLine) {
    let (lines, origins) = getLinesAndOrigins()
    if lines.isEmpty { return }
    for i in 0..<lines.count {
      ctx.textPosition = origins[i]
      let line = lines[i]
      let lastIndex = lines.lastIndex!
      if i < lastIndex || line.range.upperBound == attrString.length { // note: range and length are both NSString UTF16 indices.
        line.draw(ctx: ctx)
      } else { // last line needs to be truncated.
        print("TRUNCATE: \(attrString.string)")
        // using the line as is does not work, because it already fits the frame width; instead create a slightly longer one.
        let longString = NSMutableAttributedString(attributedString: attrString.attributedSubstring(from: NSRange(line.range)))
        longString.mutableString.append("\u{2026}") // Append something to make the line too long; use ellipsis for consistency.
        let longLine = CTLine.make(attrString: longString)
        guard let truncated = longLine.truncate(width: width, truncationType: truncationType, truncationLine: truncationLine) else { print("TOO SMALL"); return }
        truncated.draw(ctx: ctx)
      }
    }
  }
}
