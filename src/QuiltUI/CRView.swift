// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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

  public var c: CGPoint {
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

  public var huggingH: CRPriority {
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

  public var huggingV: CRPriority {
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

  public var compressionH: CRPriority {
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

  public var compressionV: CRPriority {
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
  public func setNeedsLayout() { needsLayout = true }
  #endif


  public var contentsScale: CGFloat {
    (layer?.contentsScale) ?? (window?.backingScaleFactor) ?? 1
  }

  public func updateContentsScale(_ contentsScale: CGFloat) {
    if let layer = layer {
      layer.updateContentsScale(contentsScale)
    }
    for subview in subviews {
      subview.updateContentsScale(contentsScale)
    }
  }


  public var color: CRColor {
    // Like backgroundColor, but non-nil.
    // Note: as of Swift 5.3, it does not appear possible to define `backgroundColor` for NSView,
    // because some NSView subclasses also define it and it results in "Ambiguous use of 'backgroundColor' errors.
    get {
      #if os(OSX)
      if let layer = layer { // If the view has a layer, assume that it provides the background color.
        return layer.color
      }
      // Other Cocoa views provide backgroundColor themselves. Try to fetch it.
      let backgroundColor = self.value(forKey: "backgroundColor") as? CRColor
      return backgroundColor ?? .clear
      #else
      return backgroundColor ?? .clear
      #endif
    }
    set {
      #if os(OSX)
      if let layer = layer {
        layer.color = newValue
      } else { // Assume that the layer provides a backgroundColor property.
        self.setValue(newValue, forKey: "backgroundColor")
      }
      setNeedsDisplay() // TODO: Necessary?
      #else
      backgroundColor = (newValue == .clear) ? nil : color
      #endif
    }
  }
}
