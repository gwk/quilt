// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

#if os(OSX)
  import AppKit
  public typealias CRFont = NSFont
  #else
  import UIKit
  public typealias CRFont = UIFont
#endif


extension CRFont {
#if os(OSX)
  public var lineHeight: Double { (ascender - descender) + leading }
#endif

  public func lineHeightForScreen(contentsScale scale: Double) -> Double {
    // The lineHeight property is not appropriate for screen layout,
    // because measurement occurs from the baseline and so we must pad each input component up to nearest pixel size.
    (ceil(ascender * scale) - floor(descender * scale) + leading * scale) / scale
  }

  public var descriptor: CRFontDescriptor {
    #if os(OSX)
      return fontDescriptor
      #else
      return fontDescriptor()
    #endif
  }

  public var fixedAdvance: Double {
    if let advanceVal: Any = descriptor.fontAttributes[CRFontDescriptor.AttributeName.fixedAdvance] {
      let n = advanceVal as! NSNumber
      return Double(n.floatValue)
    } else {
      return 0
    }
  }
}
