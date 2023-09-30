// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import SpriteKit


extension SKLabelNode {

  public var alignmentModes: (SKLabelHorizontalAlignmentMode, SKLabelVerticalAlignmentMode) {
    get { (horizontalAlignmentMode, verticalAlignmentMode) }
    set {
      horizontalAlignmentMode = newValue.0
      verticalAlignmentMode = newValue.1
    }
  }
}
