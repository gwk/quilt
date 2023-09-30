// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import Foundation
import CoreText


extension CTLine {

  public static func make(attrString: NSAttributedString) -> CTLine {
    CTLineCreateWithAttributedString(attrString)
  }

  var range: CountableRange<Int> {
    let r = CTLineGetStringRange(self)
    return r.location..<(r.location + r.length)
  }

  public func draw(ctx: CGContext) { CTLineDraw(self, ctx) }

  public func truncate(width: Double, truncationType: CTLineTruncationType = .end, truncationLine: CTLine) -> CTLine? {
    CTLineCreateTruncatedLine(self, Double(width), truncationType, truncationLine)
  }
}
