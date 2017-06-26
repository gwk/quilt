// © 2014 George King. Permission to use this file is granted in license-qk.txt.

#if os(OSX)
  import AppKit
  public typealias CRFont = NSFont
  #else
  import UIKit
  public typealias CRFont = UIFont
#endif


extension CRFont {
#if os(OSX)
  public var lineHeight: Flt { return (ascender - descender) + leading }
#endif

  public var descriptor: CRFontDescriptor {
    #if os(OSX)
      return fontDescriptor
      #else
      return fontDescriptor()
    #endif
  }

  public var fixedAdvance: Flt {
    if let advanceVal: Any = descriptor.fontAttributes[CRFontDescriptor.AttributeName.fixedAdvance] {
      let n = advanceVal as! NSNumber
      return Flt(n.floatValue)
    } else {
      return 0
    }
  }
}
