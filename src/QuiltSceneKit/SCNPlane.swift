// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

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
