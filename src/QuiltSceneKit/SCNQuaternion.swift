// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

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
