// © 2015 George King. Permission to use this file is granted in license-qk.txt.

#if os(OSX)
  import AppKit
  public typealias CRFontDescriptor = NSFontDescriptor
  let CRFontAttrFixedAdvance = NSFontDescriptor.AttributeName.fixedAdvance
  #else
  import UIKit
  public typealias CRFontDescriptor = UIFontDescriptor
  let CRFontAttrFixedAdvance = UIFontDescriptorFixedAdvanceAttribute
#endif
