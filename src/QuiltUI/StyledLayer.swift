// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import QuartzCore


open class StyledLayer: CALayer {

  public var layerStyle: LayerStyle = .emptyStyle {
    didSet {
      layerStyle.apply(to: self)
    }
  }
}
