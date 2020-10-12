// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import QuartzCore


public class StyledLayer: CALayer {

  public var layerStyle: LayerStyle = .emptyStyle {
    didSet {
      layerStyle.apply(to: self)
    }
  }
}
