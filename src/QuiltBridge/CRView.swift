// © 2014 George King. Permission to use this file is granted in license-qk.txt.

#if os(OSX)
  import AppKit
  public typealias CRView = NSView
  public typealias CRFlex = NSView.AutoresizingMask
  public typealias CRAxis = NSLayoutConstraint.Orientation
  public typealias CRPriority = NSLayoutConstraint.Priority
#else
  import UIKit
  public typealias CRView = UIView
  public typealias CRFlex = UIViewAutoresizing
  public typealias CRAxis = UILayoutConstraintAxis
  public typealias CRPriority = UILayoutPriority
#endif

import Quilt


extension CRFlex {

#if os(OSX)
  public static var N: CRFlex { return none }
  public static var W: CRFlex { return width }
  public static var H: CRFlex { return height }
  public static var L: CRFlex { return minXMargin }
  public static var R: CRFlex { return maxXMargin }
  public static var T: CRFlex { return minYMargin }
  public static var B: CRFlex { return maxYMargin }
#else
  public static var N: CRFlex { return None }
  public static var W: CRFlex { return FlexibleWidth }
  public static var H: CRFlex { return FlexibleHeight }
  public static var L: CRFlex { return FlexibleLeftMargin }
  public static var R: CRFlex { return FlexibleRightMargin }
  public static var T: CRFlex { return FlexibleTopMargin }
  public static var B: CRFlex { return FlexibleBottomMargin }
#endif

  public static var Size: CRFlex { return [W, H] }
  public static var Hori: CRFlex { return [L, R] }
  public static var Vert: CRFlex { return [T, B] }
  public static var Pos: CRFlex { return [Hori, Vert] }
  public static var WL: CRFlex { return [W, L] }
  public static var WR: CRFlex { return [W, R] }
}


extension CRView {


  public convenience init(frame: CGRect, name: String, parent: CRView? = nil, flex: CRFlex? = nil) {
    self.init(frame: frame)
    helpInit(name: name, parent: parent, flex: flex)
  }

  public convenience init(frame: CGRect, parent: CRView, flex: CRFlex? = nil) {
    self.init(frame: frame)
    helpInit(name: nil, parent: parent, flex: flex)
  }

  public convenience init(size: CGSize, name: String? = nil, parent: CRView? = nil, flex: CRFlex? = nil) {
    self.init(frame: CGRect(size))
    helpInit(name: name, parent: parent, flex: flex)
  }

  public convenience init(name: String, parent: CRView? = nil, flex: CRFlex? = nil) {
    self.init(frame: frameInit)
    helpInit(name: name, parent: parent, flex: flex)
  }

  public func helpInit(name: String?, parent: CRView?, flex: CRFlex?) {
    if let name = name {
      self.name = name
    }
    if let parent = parent {
      parent.addSubview(self)
    }
    if let flex = flex {
      self.flex = flex
    }
  }

  public func addSubviews(_ subviews: CRView...) {
    for v in subviews {
      addSubview(v)
    }
  }

  public func removeAllSubviews() {
    for v in subviews {
      v.removeFromSuperview()
    }
  }

  public var name: String {
    get {
      #if os(OSX)
        return accessibilityIdentifier()
        #else
        return accessibilityIdentifier!
      #endif
    }
    set {
      assert(newValue.isSym)
      #if os(OSX)
        setAccessibilityIdentifier(newValue)
        #else
        accessibilityIdentifier = newValue
      #endif
    }
  }

  public func describeTree(_ depth: Int = 0) {
    errZ(String(repeating: " ", count: depth))
    errL(description)
  }

  public var flex: CRFlex {
    get { return autoresizingMask }
    set { autoresizingMask = newValue }
  }

  public var o: CGPoint {
    get { return frame.origin }
    set { frame.origin = newValue }
  }

  public var s: CGSize {
    get { return frame.size }
    set { frame.size = newValue }
  }

  public var x: CGFloat {
    get { return frame.origin.x }
    set { frame.origin.x = newValue }
  }

  public var y: CGFloat {
    get { return frame.origin.y }
    set { frame.origin.y = newValue }
  }

  public var w: CGFloat {
    get { return frame.size.width }
    set { frame.size.width = newValue }
  }

  public var h: CGFloat {
    get { return frame.size.height }
    set { frame.size.height = newValue }
  }

  public var r: CGFloat {
    get { return x + w }
    set { x = newValue - w }
  }

  var b: CGFloat {
    get { return y + h }
    set { y = newValue - h }
  }

  var c: CGPoint {
    get {
      #if os(OSX)
        return CGPoint(x + (0.5 * w), y + (0.5 * h))
      #else
        return center
      #endif
    }
    set {
      #if os(OSX)
        o = CGPoint(newValue.x - (0.5 * w), newValue.y - (0.5 * h))
        #else
        center = newValue
      #endif
    }
  }

  var huggingH: CRPriority {
    get {
      #if os(OSX)
        return contentHuggingPriority(for: .horizontal)
        #else
        return contentHuggingPriorityForAxis(.Horizontal)
      #endif
    }
    set {
      #if os(OSX)
        return setContentHuggingPriority(huggingH, for: .horizontal)
        #else
        return setContentHuggingPriority(huggingH, forAxis: .Horizontal)
      #endif
    }
  }

  var huggingV: CRPriority {
    get {
      #if os(OSX)
        return contentHuggingPriority(for: .vertical)
        #else
        return contentHuggingPriorityForAxis(.Vertical)
      #endif
    }
    set {
      #if os(OSX)
        return setContentHuggingPriority(huggingV, for: .vertical)
        #else
        return setContentHuggingPriority(huggingV, forAxis: .Vertical)
      #endif
    }
  }

  var compressionH: CRPriority {
    get {
      #if os(OSX)
        return contentCompressionResistancePriority(for: .horizontal)
        #else
        return contentCompressionResistancePriorityForAxis(.Horizontal)
      #endif
    }
    set {
      #if os(OSX)
        return setContentCompressionResistancePriority(compressionH, for: .horizontal)
        #else
        return setContentCompressionResistancePriority(compressionH, forAxis: .Horizontal)
      #endif
    }
  }

  var compressionV: CRPriority {
    get {
      #if os(OSX)
        return contentCompressionResistancePriority(for: .vertical)
        #else
        return contentCompressionResistancePriorityForAxis(.Vertical)
      #endif
    }
    set {
      #if os(OSX)
        return setContentCompressionResistancePriority(compressionV, for: .vertical)
        #else
        return setContentCompressionResistancePriority(compressionV, forAxis: .Vertical)
      #endif
    }
  }

  #if os(OSX)
    func setNeedsDisplay() { needsDisplay = true }
  #endif
}

