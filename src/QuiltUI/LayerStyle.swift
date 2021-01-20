// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import QuartzCore


open class LayerStyle: NSCopying {

  public var color: CRColor
  public var cornerRadius: CGFloat
  public var cornerMask: CACornerMask
  public var borderColor: CRColor
  public var borderWidth: CGFloat


  public init(
    color: CRColor = .clear,
    cornerRadius: CGFloat = 0,
    cornerMask: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner],
    borderColor: CRColor = .clear,
    borderWidth: CGFloat = 0) {

    self.color = color
    self.cornerRadius = cornerRadius
    self.cornerMask = cornerMask
    self.borderColor = borderColor
    self.borderWidth = borderWidth
  }


  public func copy(with zone: NSZone? = nil) -> Any {
    LayerStyle(
      color: color,
      cornerRadius: cornerRadius,
      cornerMask: cornerMask,
      borderColor: borderColor,
      borderWidth: borderWidth)
  }


  public func apply(to layer: CALayer) {
    layer.color = color
    layer.cornerRadius = cornerRadius
    layer.maskedCorners = cornerMask
    layer.borderColor = (borderColor == .clear ? nil : borderColor.cgColor)
    layer.borderWidth = borderWidth
  }

  public static let emptyStyle = LayerStyle()
}
