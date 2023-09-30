// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

#if os(OSX)
  import AppKit
  public typealias CRFontDescriptor = NSFontDescriptor
  let CRFontAttrFixedAdvance = NSFontDescriptor.AttributeName.fixedAdvance
  #else
  import UIKit
  public typealias CRFontDescriptor = UIFontDescriptor
  let CRFontAttrFixedAdvance = UIFontDescriptorFixedAdvanceAttribute
#endif
