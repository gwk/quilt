// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
