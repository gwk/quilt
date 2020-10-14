// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit


public extension SCNBox {

  var size: V3 {
    get { return V3(width, height, length) }
    set {
      width = newValue.x
      height = newValue.y
      length = newValue.z
    }
  }
}
