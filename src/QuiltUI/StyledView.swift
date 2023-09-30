// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import QuartzCore


open class StyledView: CRView {

  public required init?(coder: NSCoder) { super.init(coder: coder) }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    #if os(OSX)
    self.wantsLayer = true // Setting `wantsLayer` creates a "layer-backed view".
    #endif
  }

  #if os(OSX)

  override public var isFlipped: Bool { true }

  override public var isOpaque: Bool { layer!.isOpaque }

  override public var wantsUpdateLayer: Bool { true }

  override public func makeBackingLayer() -> CALayer { StyledLayer() }

  public var styledLayer: StyledLayer { layer as! StyledLayer }

  public var layerStyle: LayerStyle {
    get { styledLayer.layerStyle }
    set { styledLayer.layerStyle = newValue }
  }


  override public func viewDidChangeBackingProperties() {
    if let window = window {
      updateContentsScale(window.backingScaleFactor)
    }
  }

  #endif
}
