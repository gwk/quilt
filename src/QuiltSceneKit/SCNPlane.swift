// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit
import QuiltUI


public extension SCNPlane {

  var size: V2 {
    get { return V2(width, height) }
    set {
      width = newValue.x
      height = newValue.y
    }
  }
}
