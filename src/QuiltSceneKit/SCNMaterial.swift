// © 2020 George King. Permission to use this file is granted in license-quilt.txt.

import SceneKit
import QuiltUI


extension SCNMaterial {


  public convenience init(flatColor: CRColor) {
    self.init()
    self.diffuse.contents = flatColor
  }

  public static var flatWhite = SCNMaterial(flatColor: .white)
  public static var flatGray = SCNMaterial(flatColor: CRColor.gray)
}
