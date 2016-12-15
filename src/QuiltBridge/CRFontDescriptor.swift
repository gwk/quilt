// © 2015 George King. Permission to use this file is granted in license-qk.txt.

#if os(OSX)
  import AppKit
  public typealias CRFontDescriptor = NSFontDescriptor
  let CRFontAttrFixedAdvance = NSFontFixedAdvanceAttribute
  #else
  import UIKit
  public typealias CRFontDescriptor = UIFontDescriptor
  let CRFontAttrFixedAdvance = UIFontDescriptorFixedAdvanceAttribute
#endif



extension CRFontDescriptor {
  public var attributes: [String : AnyObject] {
    #if os(OSX)
      return fontAttributes as [String : AnyObject]
      #else
      return fontAttributes()
    #endif
  }
}
