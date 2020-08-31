// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

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
