// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import simd
import SceneKit
import CoreGraphics
import QuiltVec


extension QF {

  var scnq: SCNQuaternion {
    let v = vector
    return SCNQuaternion(x: CGFloat(v.x), y: CGFloat(v.y), z: CGFloat(v.z), w: CGFloat(v.w))
  }
}

extension QD {

  var scnq: SCNQuaternion {
    let v = vector
    return SCNQuaternion(x: CGFloat(v.x), y: CGFloat(v.y), z: CGFloat(v.z), w: CGFloat(v.w))
  }
}
