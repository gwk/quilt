// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation
import CoreText


extension CTFrame {

  public var lines: [CTLine] { CTFrameGetLines(self) as! [CTLine] }

  public var path: CGPath { CTFrameGetPath(self) }

  public var range: CountableRange<Int> { CountableRange(CTFrameGetStringRange(self)) }

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

  public func draw(ctx: CGContext, attrString: NSAttributedString, width: Double, truncationType: CTLineTruncationType = .end, truncationLine: CTLine) {
    let (lines, origins) = getLinesAndOrigins()
    if lines.isEmpty { return }
    for i in 0..<lines.count {
      ctx.textPosition = origins[i]
      let line = lines[i]
      let lastIndex = lines.lastIndex!
      if i < lastIndex || line.range.upperBound == attrString.length { // note: range and length are both NSString UTF16 indices.
        line.draw(ctx: ctx)
      } else { // last line needs to be truncated.
        // using the line as is does not work, because it already fits the frame width; instead create a slightly longer one.
        let longString = NSMutableAttributedString(attributedString: attrString.attributedSubstring(from: NSRange(line.range)))
        longString.mutableString.append("\u{2026}") // Append something to make the line too long; use ellipsis for consistency.
        let longLine = CTLine.make(attrString: longString)
        guard let truncated = longLine.truncate(width: width, truncationType: truncationType, truncationLine: truncationLine) else {
          print("CTFrame.draw: line truncation failed")
          return
        }
        truncated.draw(ctx: ctx)
      }
    }
  }
}
