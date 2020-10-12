// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import QuartzCore


public class LayerStyle {

  public var color: CRColor
  public var cornerRadius: CGFloat
  public var borderColor: CRColor
  public var borderWidth: CGFloat

  public init(color: CRColor = .clear, cornerRadius: CGFloat = 0, borderColor: CRColor = .clear, borderWidth: CGFloat = 0) {
    self.color = color
    self.cornerRadius = cornerRadius
    self.borderColor = borderColor
    self.borderWidth = borderWidth
  }

  public func apply(to layer: CALayer) {
    layer.color = color
    layer.cornerRadius = cornerRadius
    layer.borderColor = (borderColor == .clear ? nil : borderColor.cgColor)
    layer.borderWidth = borderWidth
  }

  public static let emptyStyle = LayerStyle()
}
