// © 2014 George King. Permission to use this file is granted in license-quilt.txt.

#if os(OSX)
  import AppKit
  public typealias CRView = NSView
  public typealias CRAxis = NSLayoutConstraint.Orientation
  public typealias CRPriority = NSLayoutConstraint.Priority
#else
  import UIKit
  public typealias CRView = UIView
  public typealias CRAxis = UILayoutConstraintAxis
  public typealias CRPriority = UILayoutPriority
#endif

import Quilt


extension CRView {

  public convenience init(frame: CGRect, name: String, parent: CRView? = nil, flex: Flex? = nil) {
    self.init(frame: frame)
    update(name: name, parent: parent, flex: flex)
  }

  public convenience init(frame: CGRect, parent: CRView, flex: Flex? = nil) {
    self.init(frame: frame)
    update(parent: parent, flex: flex)
  }

  public convenience init(size: CGSize = CGRect.frameInit.size, name: String? = nil, parent: CRView? = nil, flex: Flex? = nil) {
    self.init(frame: CGRect(size))
    update(name: name, parent: parent, flex: flex)
  }

  public func update(frame: CGRect? = nil, name: String? = nil, parent: CRView? = nil, flex: Flex? = nil) {
    if let frame = frame {
      self.frame = frame
    }
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

  public var name: String? {
    get {
      #if os(OSX)
        return accessibilityIdentifier()
        #else
        return accessibilityIdentifier
      #endif
    }
    set {
      if let n = newValue { assert(n.isSym) }
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
        return setContentHuggingPriority(newValue, for: .horizontal)
      #else
        return setContentHuggingPriority(newValue, forAxis: .Horizontal)
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
        return setContentHuggingPriority(newValue, for: .vertical)
        #else
        return setContentHuggingPriority(newValue, forAxis: .Vertical)
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
        return setContentCompressionResistancePriority(newValue, for: .horizontal)
        #else
        return setContentCompressionResistancePriority(newValue, forAxis: .Horizontal)
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
        return setContentCompressionResistancePriority(newValue, for: .vertical)
        #else
        return setContentCompressionResistancePriority(newValue, forAxis: .Vertical)
      #endif
    }
  }

  #if os(OSX)
    public func setNeedsDisplay() { needsDisplay = true }
  #endif


  public var contentsScale: CGFloat {
    return (layer?.contentsScale) ?? (window?.backingScaleFactor) ?? 1
  }

  public func updateContentsScale(_ contentsScale: CGFloat) {
    if let layer = layer {
      layer.updateContentsScale(contentsScale)
    }
    for subview in subviews {
      subview.updateContentsScale(contentsScale)
    }
  }
}

