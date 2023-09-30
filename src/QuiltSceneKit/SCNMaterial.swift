// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

import SceneKit
import QuiltUI


extension SCNMaterial {


  public convenience init(flatColor: CRColor) {
    self.init()
    self.diffuse.contents = flatColor
  }

  public static var flatWhite = SCNMaterial(flatColor: .white)
  public static var flatGray = SCNMaterial(flatColor: CRColor.gray)


  public static func physMat(name: String? = nil, diffuse: Any? = nil, rough: Any? = nil, metal: Any?) -> SCNMaterial {
    let mat = SCNMaterial()
    mat.name = name
    mat.lightingModel = .physicallyBased
    mat.diffuse.contents = diffuse
    mat.roughness.contents = rough
    mat.metalness.contents = metal
    return mat
  }
}
