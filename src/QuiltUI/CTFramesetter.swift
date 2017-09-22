// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import CoreText
import Foundation


extension CTFramesetter {

  public class func make(attributedString: NSAttributedString) -> CTFramesetter {
    return CTFramesetterCreateWithAttributedString(attributedString as CFAttributedString)
  }

  public var typesetter: CTTypesetter { return CTFramesetterGetTypesetter(self) }

  public func createFrame(range: CountableRange<Int> = 0..<0, path: CGPath) -> CTFrame {
    // TODO: attributes; currently passing nil.
    // kCTFrameProgressionAttributeName // determines the line-stacking behavior for a frame and does not affect the appearance of the glyphs within that frame.
    // kCTFramePathFillRuleAttributeName // a CFNumber containing a CTFramePathFillRule constant. The default value is evenOdd.
    // kCTFramePathWidthAttributeName //  a CFNumber containing a value specifying the frame width. The default width value is zero.
    // kCTFrameClippingPathsAttributeName // a CFArrayRef containing CFDictionaryRefs. Each dictionary should have a kCTFramePathClippingPathAttributeName key-value pair, and can have a kCTFramePathFillRuleAttributeName key-value pair and kCTFramePathFillRuleAttributeName key-value pair as optional parameters.
    // kCTFramePathClippingPathAttributeName // a CGPathRef specifying a clipping path.
    return CTFramesetterCreateFrame(self, CFRange(range), path, nil)
  }

  public func createFrame(range: CountableRange<Int> = 0..<0, bounds: CGRect) -> CTFrame {
    return createFrame(range: range, path: CGPath(rect: bounds, transform: nil))
  }

  public func suggestFrameSize(range: CountableRange<Int> = 0..<0, constraintSize: CGSize) -> (CGSize, CountableRange<Int>) {
    var fitRange: CFRange = .zero
    let fitSize = CTFramesetterSuggestFrameSizeWithConstraints(self, CFRange(range), nil, constraintSize, &fitRange)
    return (fitSize, CountableRange(fitRange))
  }
}
