// © 2017 George King. Permission to use this file is granted in license-quilt.txt.

import QuartzCore


open class TextLayerStyle: LayerStyle {

  public var font: CRFont = .systemFont(ofSize: 12)
  public var textColor: CRColor = .black

  public init(
    color: CRColor = .clear,
    cornerRadius: CGFloat = 0,
    cornerMask: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner],
    borderColor: CRColor = .clear,
    borderWidth: CGFloat = 0,
    font: CRFont = .systemFont(ofSize: 12),
    textColor: CRColor = .black) {

    super.init(
      color: color,
      cornerRadius: cornerRadius,
      cornerMask: cornerMask,
      borderColor: borderColor,
      borderWidth: borderWidth)

    self.font = font
    self.textColor = textColor
  }


  public override func copy(with zone: NSZone? = nil) -> Any {
    TextLayerStyle(
      color: color,
      cornerRadius: cornerRadius,
      cornerMask: cornerMask,
      borderColor: borderColor,
      borderWidth: borderWidth,
      font: font,
      textColor: textColor)
  }


  public override func apply(to layer: CALayer) {
    super.apply(to: layer)
    if let layer = layer as? TextLayer {
      layer.textColor = textColor
      layer.font = font
    }
  }
}
